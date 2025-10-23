data "aws_availability_zones" "available" {
  state = "available"
}

data "http" "current_ip" {
  depends_on = [
    module.ec2_instance
  ]

  url = "https://ifconfig.me/ip"
}

data "dns_a_record_set" "this" {
  host = module.ec2_instance.public_dns
}