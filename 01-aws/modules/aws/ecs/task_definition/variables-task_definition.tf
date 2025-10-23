variable "container_definitions" {
  description = "A list of valid container definitions provided as a single valid JSON document."
  type        = any
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task."
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task."
  type        = list(string)
  default     = ["FARGATE"]
}

variable "cpu" {
  description = "Number of cpu units used by the task."
  type        = number
  default     = 10
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the task."
  type        = number
  default     = 128
}