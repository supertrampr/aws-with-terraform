resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    "Name" = "vpc-${local.suffix}"
  }
}

resource "aws_subnet" "private" {
  for_each = toset(var.subnets_availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets_cidr_block["${replace(each.key, var.aws_region, "")}"]
  availability_zone = each.value

  tags = {
    "Name" = "pvt-subnet-${replace(each.key, var.aws_region, "")}"
  }
}

resource "aws_subnet" "public" {
  for_each = toset(var.subnets_availability_zones)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets_cidr_block["${replace(each.key, var.aws_region, "")}"]
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    "Name" = "pub-subnet-${replace(each.key, var.aws_region, "")}"
  }
}
