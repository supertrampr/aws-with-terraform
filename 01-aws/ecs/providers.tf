provider "aws" {
  profile = "formazione-comacchio"
  # region     = var.aws_region
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key

  default_tags {
    tags = {
      course = "introduction-to-terraform"
      owner  = var.owner
    }
  }
}