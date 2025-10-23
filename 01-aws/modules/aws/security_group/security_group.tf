resource "aws_security_group" "this" {
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "nsg-${local.suffix}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = var.security_ingress_rules

  description       = "Rule for ${each.key}"
  ip_protocol       = each.value["ip_protocol"]
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value["cidr_ipv4"]
  from_port         = each.value["ip_protocol"] != "-1" ? each.value["from_port"] : null
  to_port           = each.value["ip_protocol"] != "-1" ? each.value["to_port"] : null
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = merge({
    internet = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }, var.security_egress_rules)

  description       = "Rule for ${each.key}"
  ip_protocol       = each.value["ip_protocol"]
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value["cidr_ipv4"]
  from_port         = each.value["ip_protocol"] != "-1" ? each.value["from_port"] : null
  to_port           = each.value["ip_protocol"] != "-1" ? each.value["to_port"] : null
}