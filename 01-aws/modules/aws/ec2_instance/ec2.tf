resource "tls_private_key" "this" {
  algorithm   = var.tls_private_key_algorithm
  rsa_bits    = var.tls_private_key_algorithm == "RSA" ? var.rsa_bits : null
  ecdsa_curve = var.tls_private_key_algorithm == "ECDSA" ? var.ecdsa_curve : null

  # lifecycle {
  #   precondition {
  #     condition = (
  #       var.tls_private_key_algorithm == "RSA" ||
  #       var.tls_private_key_algorithm == "ECDSA" ||
  #       var.tls_private_key_algorithm == "ED25519"
  #     )
  #     error_message = "tls_private_key_algorithm must be of values: RSA, ECDSA, ED25519."
  #   }
  # }
}

resource "aws_key_pair" "this" {
  key_name   = "ssh-connection"
  public_key = tls_private_key.this.public_key_openssh

}

data "aws_ami" "this" {
  most_recent = true
  owners      = var.ami_owners_ids

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_eip" "this" {
  count = var.associate_static_public_ip ? 1 : 0

  tags = {
    "Name" = "eip-instance-${local.suffix}"
  }
}

resource "aws_instance" "this" {
  ami                         = try(length(var.ami), 0) == 0 ? data.aws_ami.this.image_id : var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.this.key_name
  subnet_id                   = var.subnet_id
  security_groups             = var.list_of_security_groups
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      ami,
      security_groups
    ]
  }

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

resource "aws_eip_association" "this" {
  count = var.associate_static_public_ip ? 1 : 0

  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this[0].allocation_id
}