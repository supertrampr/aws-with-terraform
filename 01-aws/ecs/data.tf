data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_network_interface" "ecs_task" {
  filter {
    name   = "tag:aws:ecs:serviceName"
    values = [module.ecs_service.name]
  }
}