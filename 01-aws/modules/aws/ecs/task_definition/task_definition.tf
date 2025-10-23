resource "aws_ecs_task_definition" "this" {
  family                   = "tasks-${local.suffix}"
  container_definitions    = var.container_definitions
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.cpu
  memory                   = var.memory
  # execution_role_arn       = data.aws_iam_role.execution_role[0].arn
}