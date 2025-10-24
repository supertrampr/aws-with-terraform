variables {
  suffix = "for-testing"
}

run "check_igw_name" {
  command = plan

  assert {
    condition     = aws_internet_gateway.this.tags["Name"] == "igw-for-testing"
    error_message = "Name does not respect constraint."
  }
}

run "igw_vpc_attached" {
  command = apply

  assert {
    condition     = aws_internet_gateway.this.vpc_id != ""
    error_message = "Internet Gateway must have a vpc attached."
  }
}