variable "subnets_ids" {
  description = "List of subnets' ids to associate with the load balancer."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "type" {
  description = "Load balancer type."
  type        = string
  default     = "network"
}

variable "security_groups_ids" {
  description = "List of security groups' ids to associate with the load balancer."
  type        = list(string)
  default     = []
}

variable "load_balancer_listeners" {
  description = "Map of object containing information about listeners."
  type = map(object({
    type     = string
    port     = number
    protocol = optional(string, "tcp")
  }))
  default = {
    "ssh" = {
      port = 2222
      type = "forward"
    }
  }
}

variable "load_balancer_target_groups" {
  description = "Map of object containing information about target groups."
  type = map(object({
    target_type = string
    port        = number
    protocol    = optional(string, "tcp")
  }))
  default = {
    "ssh" = {
      port        = 22
      target_type = "instance"
    }
  }
}