resource "random_password" "this" {
  count = var.is_password_managed ? 0 : 1

  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "!_."
}