output "visit_nginx" {
  description = "Visit NGINX home page."
  value = templatefile("${path.root}/outputs/nginx.txt", {
    hostname = data.aws_network_interface.ecs_task.association[0].public_dns_name
  })
}