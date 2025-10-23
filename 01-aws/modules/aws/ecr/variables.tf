variable "force_delete" {
  description = "If true, will delete the repository even if it contains images."
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository."
  type        = string
  default     = "MUTABLE"

  validation {
    condition = (
      var.image_tag_mutability == "MUTABLE" ||
      var.image_tag_mutability == "IMMUTABLE" ||
      var.image_tag_mutability == "IMMUTABLE_WITH_EXCLUSION" ||
      var.image_tag_mutability == "MUTABLE_WITH_EXCLUSION"
    )
    error_message = <<EOT
image_tag_mutability variable can be of value:
- MUTABLE
- IMMUTABLE
- IMMUTABLE_WITH_EXCLUSION
- MUTABLE_WITH_EXCLUSION
EOT
  }
}

