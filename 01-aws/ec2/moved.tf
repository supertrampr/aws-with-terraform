moved {
  from = aws_vpc_security_group_ingress_rule.ssh
  to   = module.ec2_security_group.aws_vpc_security_group_ingress_rule.this["ssh"]
}

moved {
  from = aws_vpc_security_group_egress_rule.internet
  to   = module.ec2_security_group.aws_vpc_security_group_egress_rule.this["internet"]
}

moved {
  from = aws_security_group.this
  to   = module.ec2_security_group.aws_security_group.this
}

