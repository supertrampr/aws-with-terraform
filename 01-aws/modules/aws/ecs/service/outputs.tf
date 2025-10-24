output "name" {
  description = "ECS service public ip."
  value       = aws_ecs_service.this.name
}