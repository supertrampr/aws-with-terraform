module "network" {
  source = "../modules/aws/network"

  owner                      = var.owner
  aws_region                 = var.aws_region
  region_code                = var.region_code
  vpc_cidr_block             = "172.16.0.0/21"
  subnets_availability_zones = data.aws_availability_zones.available.names
  private_subnets_cidr_block = var.private_subnets_cidr_block
  public_subnets_cidr_block  = var.public_subnets_cidr_block
}

module "security_group" {
  source = "../modules/aws/security_group"

  for_each = local.security_groups

  owner                  = "${each.key}-${var.owner}"
  region_code            = var.region_code
  vpc_id                 = module.network.vpc_id
  security_ingress_rules = each.value["security_ingress_rules"]
}

module "ec2_instance" {
  source = "../modules/aws/ec2_instance"

  owner                      = var.owner
  rsa_bits                   = 4096
  subnet_id                  = module.network.private_subnets_ids["eu-central-1a"]
  associate_static_public_ip = false
  region_code                = var.region_code
  user_data = templatefile("${path.root}/scripts/ec2-init.sh", {
    apt_packages_to_install = join(" ", var.ec2_apt_packages_to_install)
  })
  list_of_security_groups = [
    module.security_group["ec2"].id
  ]
}

resource "local_file" "ssh" {
  filename        = "ssh_key"
  file_permission = "0400"
  content         = module.ec2_instance.ssh_private_key
}

module "network_load_balancer" {
  source = "../modules/aws/load_balancer"

  owner       = var.owner
  region_code = var.region_code
  subnets_ids = [for id in module.network.public_subnets_ids : id]
  vpc_id      = module.network.vpc_id
  security_groups_ids = [
    module.security_group["lb"].id
  ]
  load_balancer_listeners = {
    "ssh" = {
      port = 2222
      type = "forward"
    }
    "web" = {
      port = 8888
      type = "forward"
    }
  }
  load_balancer_target_groups = {
    "ssh" = {
      port        = 22
      target_type = "instance"
    }
    "web" = {
      port        = 80
      target_type = "instance"
    }
  }
}

resource "aws_lb_target_group_attachment" "this" {
  for_each = toset([
    "web",
    "ssh"
  ])

  target_group_arn = module.network_load_balancer.lb_target_groups_arn["${each.key}"]
  target_id        = module.ec2_instance.id
}

module "db" {
  source = "../modules/aws/database"

  owner       = var.owner
  region_code = var.region_code
  subnet_ids  = [for v in module.network.private_subnets_ids : v]
  security_group_ids = [
    module.security_group["db"].id
  ]
}