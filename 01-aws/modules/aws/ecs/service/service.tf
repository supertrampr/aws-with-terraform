resource "aws_ecs_service" "this" {
  name                    = "service-${local.suffix}"
  cluster                 = var.cluster_arn
  task_definition         = var.task_definition_arn
  launch_type             = var.launch_type
  desired_count           = var.replica_count
  enable_ecs_managed_tags = var.is_ecs_managed_tags_enabled

  network_configuration {
    subnets          = var.network_configuration["list_of_subnets"]
    assign_public_ip = var.network_configuration["assign_public_ip"]
    security_groups  = var.network_configuration["security_groups"]
  }
}