resource "aws_ecs_service" "this" {
  name            = "service-${local.suffix}"
  cluster         = var.cluster_arn
  task_definition = var.task_definition_arn
  desired_count   = var.replica_count

  network_configuration {
    subnets          = var.network_configuration["list_of_subnets"]
    assign_public_ip = var.network_configuration["assign_public_ip"]
  }
}