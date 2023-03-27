output "ecs_target_group_arn" {
  value = aws_lb_target_group.tg-ecs-app.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}