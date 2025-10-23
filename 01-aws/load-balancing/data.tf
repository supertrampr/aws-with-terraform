data "aws_availability_zones" "available" {
  state = "available"
}

data "http" "current_ip" {
  url = "https://ifconfig.me/ip"
}

data "dns_a_record_set" "this" {
  count = try(length(module.network_load_balancer.dns_name), 0) > 0 ? 1 : 0

  host = module.network_load_balancer.dns_name
}