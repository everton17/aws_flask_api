resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.alb_is_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.security_groups]
  subnets            = var.alb_subnets
  tags = merge(
    { Name = var.alb_name },
    local.common_tags
  )
}

resource "aws_lb_listener" "default-http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.default_http_listener_target_group_arn
  }

  tags = merge(
    { Name = "Defaul-HTTP" },
    local.common_tags
  )
}