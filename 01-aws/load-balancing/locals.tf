locals {
  ssh_connection = <<EOT
The instance has been deployed, you can connect to it by running command:

    ssh -i ${path.module}/${local_file.ssh.filename} -p 2222 ubuntu@${try(module.network_load_balancer.dns_name, "")}

EOT


  lb_to_ec2_ssh_security_rules = {
    for k, v in module.network.public_subnets_cidr_block : "ssh_for_${k}" =>
    {
      ip_protocol = "tcp"
      cidr_ipv4   = v
      to_port     = 22
      from_port   = 22
    }
  }
  lb_to_ec2_web_security_rules = {
    for k, v in module.network.public_subnets_cidr_block : "web_for_${k}" =>
    {
      ip_protocol = "tcp"
      cidr_ipv4   = v
      to_port     = 80
      from_port   = 80
    }
  }
  ec2_security_rules = merge(
    {
      "ssh" = {
        ip_protocol = "tcp"
        cidr_ipv4   = "${data.http.current_ip.response_body}/32"
        to_port     = 22
        from_port   = 22
      }
      web = {
        ip_protocol = "tcp"
        cidr_ipv4   = "0.0.0.0/0"
        to_port     = 80
        from_port   = 80
      }
  }, local.lb_to_ec2_ssh_security_rules, local.lb_to_ec2_web_security_rules)

  security_groups = merge(var.security_groups, {
    "ec2" = {
      security_ingress_rules = local.ec2_security_rules
    }
    "lb" = {
      security_ingress_rules = {
        "ssh_listener" = {
          ip_protocol = "tcp"
          cidr_ipv4   = "${data.http.current_ip.response_body}/32"
          to_port     = 2222
          from_port   = 2222
        }
        "web_listener" = {
          ip_protocol = "tcp"
          cidr_ipv4   = "0.0.0.0/0"
          to_port     = 8888
          from_port   = 8888
        }
        "ephemeral_port" = {
          ip_protocol = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_ipv4   = "0.0.0.0/0"
        }
      }
    }
  })
}