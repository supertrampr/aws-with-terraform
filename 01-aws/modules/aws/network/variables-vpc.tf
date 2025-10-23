variable "vpc_cidr_block" {
  description = "VPC cidr block."
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames association in vpc."
  type        = bool
  default     = true
}