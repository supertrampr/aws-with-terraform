resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "vpc-${var.suffix}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "igw-${var.suffix}"
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  map_public_ip_on_launch = each.key == "public"

  tags = {
    "Name" = "${each.key}-subnet-${var.suffix}"
  }
}

resource "aws_eip" "this" {

  tags = {
    "Name" = "eip-${var.suffix}"
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.this["public"].id
  allocation_id = aws_eip.this.allocation_id

  tags = {
    "Name" = "nat-${var.suffix}"
  }
}

resource "aws_route_table" "this" {
  for_each = toset([
    "private",
    "public"
  ])

  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "rtb-${var.suffix}"
  }
}

resource "aws_route" "this" {
  for_each = toset([
    "private",
    "public"
  ])
  route_table_id         = aws_route_table.this[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = each.key == "private" ? aws_nat_gateway.this.id : null
  gateway_id             = each.key == "public" ? aws_internet_gateway.this.id : null
}

resource "aws_route_table_association" "this" {
  for_each = toset([
    "private",
    "public"
  ])
  route_table_id = aws_route_table.this[each.key].id
  subnet_id      = aws_subnet.this[each.key].id
}