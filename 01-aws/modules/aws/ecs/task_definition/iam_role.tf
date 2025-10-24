resource "aws_iam_role" "execution" {
  name = "ecs-task-execution-role"

  assume_role_policy = var.policy
}

resource "aws_iam_role_policy_attachment" "execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.execution.name
}

