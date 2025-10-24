data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

# tflint-ignore: terraform_unused_declarations
data "http" "nginx" {
  url = "http://${aws_instance.this.public_ip}"

  retry {
    attempts     = 10
    min_delay_ms = 10000
    max_delay_ms = 30000
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners = [
    "099720109477"
  ]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}