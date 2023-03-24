resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [var.ecs_capacity_provider]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = var.ecs_capacity_provider
  }
}

data "template_file" "app" {
  template = file(var.ecs_template_path)

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.ecs_task_definition_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = [var.ecs_lounch_type]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.app.rendered

  tags = merge(
    { Name = var.ecs_service_name },
    local.common_tags
  )
}

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "ecs-app-log-group" {
  name              = "/ecs/${var.ecs_service_name}"
  retention_in_days = 30

  tags = merge(
    { Name = "ecs-${var.ecs_service_name}-log-group" },
    local.common_tags
  )
}

resource "aws_cloudwatch_log_stream" "ecs-app-log-stream" {
  name           = "ecs-${var.ecs_service_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.ecs-app-log-group.name
}

resource "aws_ecs_service" "app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = var.ecs_lounch_type

  network_configuration {
    security_groups  = [var.ecs_service_security_group]
    subnets          = var.ecs_service_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-ecs-app.id
    container_name   = var.ecs_service_container_name
    container_port   = var.app_port
  }

  tags = merge(
    { Name = "ecs-${var.ecs_service_container_name}-app-service" },
    local.common_tags
  )

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]
}