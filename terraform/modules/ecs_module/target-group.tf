resource "aws_lb_target_group" "tg-ecs-app" {
  name        = var.ecs_target_group_name
  port        = var.ecs_target_group_port
  protocol    = var.ecs_target_group_protocol
  target_type = var.ecs_target_group_type
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = var.ecs_target_group_protocol
    matcher             = "200-399"
    timeout             = "3"
    path                = var.ecs_target_healthcheck_path
    unhealthy_threshold = "2"
  }
}