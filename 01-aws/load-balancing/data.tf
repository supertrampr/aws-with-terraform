data "aws_availability_zones" "available" {
  state = "available"
}

data "http" "current_ip" {
  url = "https://ifconfig.me/ip"
}

data "dns_a_record_set" "this" {
  host = module.network_load_balancer.dns_name
}