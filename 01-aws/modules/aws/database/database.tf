resource "aws_db_subnet_group" "this" {
  name       = "snet-grp-${local.suffix}"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  db_name                     = "db${var.owner}${var.region_code}"
  instance_class              = var.instance_type
  allocated_storage           = var.allocated_storage
  apply_immediately           = var.apply_changes_immediately
  availability_zone           = var.availability_zone
  db_subnet_group_name        = aws_db_subnet_group.this.name
  engine                      = var.engine
  engine_version              = var.engine_version
  manage_master_user_password = var.is_password_managed ? var.is_password_managed : null
  username                    = var.username
  password                    = var.is_password_managed ? null : random_password.this[0].result
  vpc_security_group_ids      = var.security_group_ids
  skip_final_snapshot         = true
}

resource "aws_db_parameter_group" "this" {
  name        = "par-grp-${local.suffix}"
  family      = var.parameter_group_family
  description = "Parameter group for ${aws_db_instance.this.db_name}"

  dynamic "parameter" {
    for_each = var.db_parameters
    iterator = par

    content {
      name         = par.value["name"]
      value        = par.value["value"]
      apply_method = par.value["apply_method"]
    }
  }
}