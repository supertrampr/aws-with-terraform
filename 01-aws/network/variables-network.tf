variable "private_subnets_cidr_block" {
  description = "Subnets' CIDR block."
  type        = map(string)
  default = {
    "a" = "172.16.0.0/24"
    "b" = "172.16.1.0/24"
    "c" = "172.16.2.0/24"
  }
}

variable "public_subnets_cidr_block" {
  description = "Subnets' CIDR block."
  type        = map(string)
  default = {
    "a" = "172.16.5.0/24"
    "b" = "172.16.6.0/24"
    "c" = "172.16.7.0/24"
  }
}