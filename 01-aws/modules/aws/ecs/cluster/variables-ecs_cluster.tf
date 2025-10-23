variable "container_insights_status" {
  description = "Status of container insights."
  type        = string
  default     = "enabled"

  validation {
    condition = (
      var.container_insights_status == "enabled" ||
      var.container_insights_status == "disabled" ||
      var.container_insights_status == "enhanced"
    )
    error_message = "container_insights_status allowed values are: enabled, disabled, enhanced."
  }
}

variable "capacity_providers" {
  description = "Set of names of one or more capacity providers to associate with the cluster."
  type        = list(string)
  default     = ["FARGATE"]
}

variable "default_capacity_provider_strategy" {
  description = "Set of capacity provider strategies to use by default for the cluster."
  type = map(object({
    base   = optional(number, 1)
    weight = optional(number, 100)
  }))
  default = {
    "FARGATE" = {
      base   = 1
      weight = 100
    }
  }
}