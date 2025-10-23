variable "subnet_id" {
  description = "Subnet id where to deploy this instance."
  type        = string
}

variable "ami" {
  description = "Amazon Machine Image of the instance."
  type        = string
  default     = null
}

variable "list_of_security_groups" {
  description = "List of security groups ids to attach to this instance."
  type        = list(string)
  default     = []
}

variable "ami_owners_ids" {
  description = "List of AMI owners ids."
  type        = list(string)
  default     = ["099720109477"]
}

variable "instance_type" {
  description = "Type family of instance."
  type        = string
  default     = "t3.micro"
}

variable "associate_static_public_ip" {
  description = "Whether to assign public ip to this instance."
  type        = bool
  default     = true
}

variable "user_data" {
  description = "Additional configuration for launching the instance."
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "Recrate instance if user data changes."
  type        = string
  default     = true
}