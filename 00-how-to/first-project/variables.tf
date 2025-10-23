variable "course" {
  description = "Name of the course."
  type        = string
  default     = "Terraform"
}

variable "to_create" {
  description = "Create or not resource."
  type        = bool
  default     = false
}

variable "map_of_courses" {
  description = "Map of courses."
  type        = map(string)
  default = {
    "first"  = "Terraform"
    "second" = "Ansible"
    "third"  = "AWS"
  }
}