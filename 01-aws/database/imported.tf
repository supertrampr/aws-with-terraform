import {
  for_each = {
    "ssh" = "arn:aws:elasticloadbalancing:eu-central-1:559050246410:targetgroup/tg-ssh-raffaele-euc1/785349efe70ed364"
    "web" = "arn:aws:elasticloadbalancing:eu-central-1:559050246410:targetgroup/tg-web-raffaele-euc1/498a3a9e36074782"
  }

  id = each.value
  to = module.network_load_balancer.aws_lb_target_group.this[each.key]
}