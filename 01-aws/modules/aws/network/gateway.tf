resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "igw-${local.suffix}"
  }
}

resource "aws_nat_gateway" "this" {
  for_each = aws_subnet.public

  subnet_id     = each.value["id"]
  allocation_id = aws_eip.this["${each.key}"].id

  tags = {
    "Name" = "nat-${local.suffix}-${each.key}"
  }
}

resource "aws_eip" "this" {
  for_each = toset(var.subnets_availability_zones)

  tags = {
    "Name" = "eip-${local.suffix}-${each.value}"
  }
}