variable "name" {
  description = "Container name."
  type        = string
}

variable "image_id" {
  description = "Image id."
  type        = string
}

variable "commands" {
  description = "Command to be executed to this container."
  type        = list(string)
  default     = []
}

variable "remove_after_exit" {
  description = "Whether to remove the container after its exit signal"
  type        = bool
  default     = true
}

