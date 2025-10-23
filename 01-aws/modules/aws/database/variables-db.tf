variable "subnet_ids" {
  description = "IDs where to create this RDS."
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs of security groups to be associated with this RDS."
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "engine" {
  description = "The database engine to use."
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The engine version to use."
  type        = string
  default     = "8.0.43"
}

variable "is_password_managed" {
  description = "Whether to let RDS manage password or not."
  type        = bool
  default     = false
}

variable "username" {
  description = "Default username for authentication."
  type        = string
  default     = "mysqladmin"
}

variable "allocated_storage" {
  description = "The amount of allocated storage in GiB."
  type        = number
  default     = 20
}

variable "apply_changes_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "AZ for the RDS instance."
  type        = string
  default     = null
}

variable "db_parameters" {
  description = "Additional db parameters."
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "immediate")
  }))
  default = [
    {
      name         = "character_set_server"
      value        = "utf8"
      apply_method = "immediate"
    },
    {
      name         = "character_set_client"
      value        = "utf8"
      apply_method = "immediate"
    },
  ]
}

variable "parameter_group_family" {
  description = "Family of parameter group."
  type        = string
  default     = "mysql8.0"
}
