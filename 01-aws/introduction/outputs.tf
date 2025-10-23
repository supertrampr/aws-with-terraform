output "private_subnets_ids" {
  description = "Private subnets' ids."
  value       = { for k, v in module.network.private_subnets_ids : k => "Subnet id in az ${k} is ${v}." }
}

output "public_subnets_ids" {
  description = "Public subnets' ids."
  value       = { for k, v in module.network.public_subnets_ids : k => "Subnet id in az ${k} is ${v}." }
}