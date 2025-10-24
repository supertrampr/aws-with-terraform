run "expect_failures" {
  command = plan

  variables {
    vpc_cidr_block = "192.168.1.0/23"
  }

  expect_failures = [
    var.vpc_cidr_block
  ]
}

run "vpc_subnet_mask" {
  command = plan

  variables {
    vpc_cidr_block = "192.168.1.0/24"
  }

  assert {
    condition     = cidrnetmask(aws_vpc.this.cidr_block) == "255.255.255.0"
    error_message = "CIDR notation of vpc was ${cidrnetmask(aws_vpc.this.cidr_block)}, but expected is: 255.255.255.0."
  }
}