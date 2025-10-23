resource "local_file" "this" {
  filename = var.file_name
  content  = var.content

  lifecycle {
    ignore_changes = all
  }
}