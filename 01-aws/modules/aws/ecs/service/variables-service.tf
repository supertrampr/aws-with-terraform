variable "cluster_arn" {
  description = "ECS cluster arn."
  type        = string
}

variable "task_definition_arn" {
  description = "ECS task definition arn."
  type        = string
}

variable "replica_count" {
  description = "Number of replicas."
  type        = number
  default     = 1
}

variable "network_configuration" {
  description = "Network configuration parameters."
  type = object({
    list_of_subnets  = list(string)
    assign_public_ip = optional(bool, false)
  })
}

