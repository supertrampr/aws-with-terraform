resource "aws_lb" "this" {
  name               = "lb-${local.suffix}"
  load_balancer_type = var.type
  security_groups    = var.security_groups_ids
  subnets            = var.subnets_ids
}

resource "aws_lb_target_group" "this" {
  for_each = var.load_balancer_target_groups

  name        = "tg-${each.key}-${local.suffix}"
  port        = each.value["target_type"] == "lambda" ? null : each.value["port"]
  protocol    = each.value["target_type"] == "lambda" ? null : upper(each.value["protocol"])
  target_type = each.value["target_type"]
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "this" {
  for_each = var.load_balancer_listeners

  load_balancer_arn = aws_lb.this.arn
  port              = each.value["port"]
  protocol          = upper(each.value["protocol"])

  default_action {
    type             = each.value["type"]
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}