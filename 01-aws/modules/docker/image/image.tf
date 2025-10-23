resource "docker_image" "this" {
  name = var.name

  dynamic "build" {
    for_each = var.is_custom_image ? [1] : []

    content {
      context = var.build_context
      tag = [
        "${var.name}:${var.image_tag}"
      ]
    }
  }
}