variable "subnets_availability_zones" {
  description = "Availability zones of subnets."
  type        = list(string)
}

variable "private_subnets_cidr_block" {
  description = "Subnets' cidr block."
  type        = map(string)
}

variable "public_subnets_cidr_block" {
  description = "Subnets' cidr block."
  type        = map(string)
}

