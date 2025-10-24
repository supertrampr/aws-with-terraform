terraform {
  backend "s3" {
    bucket = "introduction-to-terraform"
    key    = "testing/terraform.tfstate"
    region = "eu-central-1"
  }
}