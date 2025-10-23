resource "aws_ecr_repository" "this" {
  name                 = "ecr-${local.suffix}"
  force_delete         = var.force_delete
  image_tag_mutability = var.image_tag_mutability
}