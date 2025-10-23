variable "ec2_apt_packages_to_install" {
  description = "List of apt packages to install."
  type        = list(string)
  default = [
    "nginx",
    "telnet",
    "mysql-client-core"
  ]
}