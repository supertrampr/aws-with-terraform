output "dns_name" {
  description = "Load balancer's DNS name."
  value       = aws_lb.this.dns_name
}

output "lb_target_groups_arn" {
  description = "ARN of all load balancer target groups."
  value       = { for k, tg in aws_lb_target_group.this : k => tg.arn }
}