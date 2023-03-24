#Variables account info

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

#Variaveis ECR
variable "ecr_registry_name" {
  description = "Registry Name"
  type        = string
  default     = "aws_flask_api"
}

#Variables ECS
variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "aws-flask-api"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "DEV"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "API"
}

variable "ecs_capacity_provider" {
  description = "Capacity Provider"
  type        = string
  default     = "FARGATE"
}

variable "ecs_service_name" {
  description = "Service Name"
  type        = string
  default     = "app"
}

variable "ecs_service_container_name" {
  description = "Service Container Name"
  type        = string
  default     = "app"
}

variable "ecs_lounch_type" {
  description = "LOUNCH TYPE"
  type        = string
  default     = "FARGATE_SPOT"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  type        = string
  default     = "myEcsTaskExecutionRole"
}

variable "ecs_template_path" {
  description = "Path for template ECS Task Definition"
  type        = string
  default     = "./template/app.json.tpl"
}

variable "app_image" {
  description = "Docker image app"
  type        = string
  default     = "url_registry"
}

variable "app_port" {
  description = "Container Port"
  type        = number
  default     = 5000
}

variable "fargate_cpu" {
  description = "cpu units for task fargate"
  type        = string
  default     = "256"
}

variable "fargate_memory" {
  description = "memory for task fargate MiB"
  type        = string
  default     = "512"
}

#Variables Load Balancer
variable "alb_name" {
  description = "ALB Name"
  type        = string
  default     = "alb-ecs-api"
}

variable "alb_default_listener_name" {
  description = "ALB defaul listener Name"
  type        = string
  default     = "alb-ecs-lab-listern"
}

#Variables Target Group
variable "ecs_target_group_name" {
  description = "ECS Target Group Name"
  type        = string
  default     = "ecs-lab"
}

variable "ecs_target_group_port" {
  description = "ECS Target Group Port"
  type        = number
  default     = 80
}

variable "ecs_target_group_protocol" {
  description = "ECS Target Group Protocol"
  type        = string
  default     = "HTTP"
}

variable "ecs_task_definition_name" {
  description = "ECS Task Definition Name"
  type        = string
  default     = "service"
}

variable "ecs_target_group_type" {
  description = "ECS Target Group type"
  type        = string
  default     = "ip"
}

variable "ecs_target_healthcheck_path" {
  description = "ECS Target Group Healthchech Path"
  type        = string
  default     = "/"
}

variable "registry" {
  description = "registry repo utilizazer"
  type        = string
  default     = "ecr"
}

#Variables VPC
variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "VPC Lab ECS"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block base for network"
  type        = string
  default     = "192.168.0.0/16"
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
  default     = "IGW-ECS-LAB"
}

variable "ngw_name" {
  description = "Nat Gateway name"
  type        = string
  default     = "NGW-ECS-LAB"
}

variable "az_count" {
  description = "ECS Target Group Port"
  type        = number
  default     = 2
}