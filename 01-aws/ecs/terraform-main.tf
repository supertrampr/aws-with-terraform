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

module "ecs_security_group" {
  source = "../modules/aws/security_group"

  owner       = var.owner
  region_code = var.region_code
  vpc_id      = module.network.vpc_id
  security_ingress_rules = {
    "web" = {
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

module "custom_image" {
  source = "../modules/docker/image"

  name            = module.ecr.repository_url
  is_custom_image = true
  build_context   = "${path.root}/containers"
}

module "container" {
  source = "../modules/docker/container"

  name     = "custom_ubuntu"
  image_id = module.custom_image.id
  commands = [
    "/bin/sh",
    "-c",
    "tail -f /dev/null"
  ]
}

module "ecr" {
  source = "../modules/aws/ecr"

  owner       = var.owner
  region_code = var.region_code
}

module "ecs_cluster" {
  source = "../modules/aws/ecs/cluster"

  owner       = var.owner
  region_code = var.region_code
}

module "ecs_task_definition" {
  source = "../modules/aws/ecs/task_definition"

  owner       = var.owner
  region_code = var.region_code
  cpu         = 256
  memory      = 512
  policy      = file("${path.root}/policies/execution_role_policy.json")
  container_definitions = templatefile("${path.root}/containers/custom_ubuntu_container_definition.json", {
    image_tag = "nginx:latest"
    port_mappings = jsonencode([{
      containerPort = 80
      hostPort      = 80
    }])
    cpu    = 256
    memory = 512
  })
}

module "ecs_service" {
  source = "../modules/aws/ecs/service"

  owner               = var.owner
  region_code         = var.region_code
  cluster_arn         = module.ecs_cluster.arn
  task_definition_arn = module.ecs_task_definition.arn
  network_configuration = {
    assign_public_ip = true
    list_of_subnets = [
      for k, v in module.network.public_subnets_ids : v
    ]
    security_groups = [
      module.ecs_security_group.id
    ]
  }
}