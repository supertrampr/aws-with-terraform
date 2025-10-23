#region PRIVATE
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.this.id

  ## Fix:
  ## - aws provider in VS code suggests that route has to be a list of object [{}]
  ## - correct type is a route block as defined below
  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = aws_nat_gateway.this["${each.key}"].id
  # }

  tags = {
    "Name" = "pvt-rtb-${local.suffix}-${each.key}"
  }
}

resource "aws_route" "private" {
  for_each = aws_route_table.private

  route_table_id         = each.value["id"]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this["${each.key}"].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  route_table_id = aws_route_table.private["${each.key}"].id
  subnet_id      = each.value["id"]
}
#endregion

#region PUBLIC
resource "aws_route_table" "public" {
  for_each = aws_subnet.public

  vpc_id = aws_vpc.this.id

  ## Fix:
  ## - aws provider in VS code suggests that route has to be a list of object [{}]
  ## - correct type is a route block as defined below
  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = aws_nat_gateway.this["${each.key}"].id
  # }

  tags = {
    "Name" = "pub-rtb-${local.suffix}-${each.key}"
  }
}

resource "aws_route" "public" {
  for_each = aws_route_table.public

  route_table_id         = each.value["id"]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  route_table_id = aws_route_table.public["${each.key}"].id
  subnet_id      = each.value["id"]
}
#endregion