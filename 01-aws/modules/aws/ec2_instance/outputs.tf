output "ssh_private_key" {
  description = "Private key for ssh connection."
  value       = tls_private_key.this.private_key_openssh
}

output "instance_public_ip" {
  description = "EC2 Instance public ip."
  value       = try(aws_eip.this[0].public_ip, "")
}

output "public_dns" {
  description = "EC2 Public DNS."
  value       = aws_instance.this.public_dns
}

output "id" {
  description = "Instance id."
  value       = aws_instance.this.id
}