variable "vpc_cidr_block" {
  description = "CIDR block for vpc."
  type        = string
  default     = "192.168.1.0/24"

  validation {
    condition     = cidrnetmask(var.vpc_cidr_block) == "255.255.255.0"
    error_message = "CIDR notation of vpc was ${cidrnetmask(var.vpc_cidr_block)}, but expected is: 255.255.255.0."
  }
}

variable "subnets" {
  description = "Subnets to deploy to vpc."
  type        = map(string)
  default = {
    "private" = "192.168.1.0/25"
    "public"  = "192.168.1.128/25"
  }
}