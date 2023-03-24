variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "ecs_task_definition_name" {
  description = "Name of Task Definition"
  type        = string
}


variable "ecs_service_name" {
  description = "Service Name"
  type        = string
}

variable "ecs_service_container_name" {
  description = "Service Container Name"
  type        = string
}


variable "app_image" {
  description = "Docker image app"
  type        = string
}

variable "app_port" {
  description = "Container Port"
  type        = number
}

variable "fargate_cpu" {
  description = "cpu units for task fargate"
  type        = string
}

variable "fargate_memory" {
  description = "memory for task fargate MiB"
  type        = string
}

variable "ecs_service_security_group" {
  description = "Security Group to ECS Service"
  type        = string
}

variable "ecs_service_subnets" {
  description = "Subnets to deploy ECS Service"
  type        = list(any)
}

variable "ecs_target_group_name" {
  description = "ECS Target Group Name"
  type        = string
}

variable "ecs_target_healthcheck_path" {
  description = "ECS Target Group Healthchech Path"
  type        = string
}

variable "ecs_target_group_type" {
  description = "ECS Target Group type"
  type        = string
  default     = "ip"
}

variable "ecs_target_group_protocol" {
  description = "ECS Target Group Protocol"
  type        = string
  default     = "HTTP"
}

variable "ecs_target_group_port" {
  description = "ECS Target Group Port"
  type        = number
  default     = 80
}

variable "ecs_template_path" {
  description = "Path for template ECS Task Definition"
  type        = string
  default     = "./template/app.json.tpl"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  type        = string
  default     = "myEcsTaskExecutionRole"
}


variable "ecs_lounch_type" {
  description = "LOUNCH TYPE"
  type        = string
  default     = "FARGATE"
}

variable "ecs_capacity_provider" {
  description = "Capacity Provider"
  type        = string
  default     = "FARGATE_SPOT"
}