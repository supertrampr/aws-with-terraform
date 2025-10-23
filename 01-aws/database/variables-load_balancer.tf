variable "security_groups" {
  description = "Map describing security groups to be created."
  type = map(object({
    security_ingress_rules = map(object({
      ip_protocol = string
      cidr_ipv4   = string
      to_port     = number
      from_port   = number
    }))
  }))
  default = {
    "ec2" = {
      security_ingress_rules = {
        "ssh" = {
          ip_protocol = "tcp"
          cidr_ipv4   = "0.0.0.0/0"
          to_port     = 22
          from_port   = 22
        }
      }
    }
  }
}