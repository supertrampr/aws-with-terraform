resource "docker_container" "this" {
  name    = var.name
  image   = var.image_id
  command = var.commands
  rm      = var.remove_after_exit
}