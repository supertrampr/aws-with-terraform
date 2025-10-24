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
    security_groups  = optional(list(string), [])
  })
}

variable "launch_type" {
  description = "Launch type on how to run this service."
  type        = string
  default     = "FARGATE"
}

variable "is_ecs_managed_tags_enabled" {
  description = "Whether to enable tags at ECS service task level."
  type        = bool
  default     = true
}