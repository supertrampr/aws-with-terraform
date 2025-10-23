variable "name" {
  description = "Name of the image."
  type        = string
  default     = "nginx:latest"
}

variable "is_custom_image" {
  description = "Whether the image to create is custom or not."
  type        = bool
  default     = false
}

variable "build_context" {
  description = "Build context."
  type        = string
  default     = null
}

variable "image_tag" {
  description = "Image tag."
  type        = string
  default     = "latest"
}