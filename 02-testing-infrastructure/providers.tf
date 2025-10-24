provider "aws" {
  default_tags {
    tags = {
      "env" = "testing"
    }
  }
}