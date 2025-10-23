module "network" {
  source = "../modules/aws/network"

  owner                      = var.owner
  aws_region                 = var.aws_region
  region_code                = "euc1"
  vpc_cidr_block             = "172.16.0.0/21"
  subnets_availability_zones = data.aws_availability_zones.available.names
  private_subnets_cidr_block = var.private_subnets_cidr_block
  public_subnets_cidr_block  = var.public_subnets_cidr_block
}

module "ec2_security_group" {
  source = "../modules/aws/security_group"

  owner       = var.owner
  region_code = "euc1"
  vpc_id      = module.network.vpc_id
  security_ingress_rules = {
    "ssh" = {
      ip_protocol = "tcp"
      cidr_ipv4   = "${data.http.current_ip.response_body}/32"
      to_port     = 22
      from_port   = 22
    }
    "web" = {
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      to_port     = 80
      from_port   = 80
    }
  }
}

module "ec2_instance" {
  source = "../modules/aws/ec2_instance"

  owner       = var.owner
  rsa_bits    = 4096
  subnet_id   = module.network.public_subnets_ids["eu-central-1a"]
  region_code = "euc1"
  user_data   = <<EOT
#!/bin/bash

sudo apt-get update 
sudo apt-get install -y nginx
sudo systemctl enable nginx

EOT
  list_of_security_groups = [
    # aws_security_group.this.id
  ]
}

resource "local_file" "ssh" {
  filename        = "ssh_key"
  file_permission = "0400"
  content         = module.ec2_instance.ssh_private_key
}