output "private_subnets_ids" {
  description = "Private subnets' ids."
  value       = { for k, v in module.network.private_subnets_ids : k => "Subnet id in az ${k} is ${v}." }
}

output "public_subnets_ids" {
  description = "Public subnets' ids."
  value       = { for k, v in module.network.public_subnets_ids : k => "Subnet id in az ${k} is ${v}." }
}

output "how_to_connect" {
  depends_on = [
    module.ec2_instance
  ]

  description = "Information on how to connect to the ec2 instance."
  value       = local.ssh_connection
}

output "visit_nginx" {
  description = "Information on how to visit Nginx welcome page."
  value       = "curl http://${module.ec2_instance.instance_public_ip}"
}