resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "ssh-connection-${var.suffix}"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "this" {
  filename        = "ssh_key_${var.suffix}"
  file_permission = "0400"
  content         = tls_private_key.this.private_key_openssh
}

resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    cidr_blocks = ["${data.http.ip.response_body}/32"]
    description = "Allow ssh from my ip"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
    description = "Allow visiting website"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
    description = "Allow all outbound"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}

resource "aws_instance" "this" {
  ami       = data.aws_ami.this.image_id
  subnet_id = aws_subnet.this["public"].id
  vpc_security_group_ids = [
    aws_security_group.this.id
  ]
  key_name                    = aws_key_pair.this.key_name
  instance_type               = "t3.micro"
  user_data_replace_on_change = true
  user_data                   = file("${path.module}/scripts/install_nginx.sh")

  tags = {
    "Name" = "ec2-${var.suffix}"
  }

  lifecycle {
    create_before_destroy = true
  }
}