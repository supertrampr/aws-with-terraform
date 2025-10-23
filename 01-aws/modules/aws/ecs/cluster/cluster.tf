resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster-${local.suffix}"

  setting {
    name  = "containerInsights"
    value = var.container_insights_status
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_provider_strategy
    iterator = strategy

    content {
      capacity_provider = strategy.key
      base              = strategy.value["base"]
      weight            = strategy.value["weight"]
    }

  }
}