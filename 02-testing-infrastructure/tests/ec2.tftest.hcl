variables {
  suffix = "for-testing"
}

run "ec2_unit_test" {
  command = plan

  assert {
    condition     = aws_instance.this.tags["Name"] == "ec2-for-testing"
    error_message = "Expected ec2 name does not meet your requirement."
  }

  assert {
    condition     = var.suffix == "for-testing" && aws_instance.this.instance_type == "t3.micro"
    error_message = "When you are testing your infrastructure you must use t3.micro has instance_type."
  }
}

run "should_be_public" {

  assert {
    condition     = aws_instance.this.public_ip != ""
    error_message = "AWS instance should be publicly exposed."
  }
}