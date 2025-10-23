# data "aws_iam_role" "execution_role" {
#   count = contains(var.requires_compatibilities, "FARGATE") ? 1 : 0

#   name = "ecsTaskExecutionRole"
# }