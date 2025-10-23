variable "vpc_id" {
  description = "VPC id."
  type        = string
}

variable "description" {
  description = "Security group description."
  type        = string
  default     = "Managed by Terraform"
}

variable "security_ingress_rules" {
  description = "Security group ingress rules."
  type = map(object({
    ip_protocol = string
    cidr_ipv4   = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
  }))
  default = {
    "ssh" = {
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
    }
  }
}

variable "security_egress_rules" {
  description = "Security group egress rules."
  type = map(object({
    ip_protocol = string
    cidr_ipv4   = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
  }))
  default = {}
}