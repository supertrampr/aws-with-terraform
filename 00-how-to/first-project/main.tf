terraform {
  required_version = ">= 0.12.6"
}

## This will implicitly install the provider plugins
## for using the local Terraform provider.
resource "local_file" "this" {
  filename = "test1.txt"
  content  = "Prima lezione di Terraform."
}