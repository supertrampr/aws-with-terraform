output "vpc_id" {
  description = "VPC's ID."
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC's ARN."
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "VPC cidr block."
  value       = aws_vpc.this.cidr_block
}

output "private_subnets_ids" {
  description = "IDs of private subnets."
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "public_subnets_ids" {
  description = "IDs of private subnets."
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "public_subnets_cidr_block" {
  description = "CIDR block of public subnets"
  value = {
    for k, v in aws_subnet.public : k => v.cidr_block
  }
}
