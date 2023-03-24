variable "alb_name" {
  description = "Aplication Load Balancer Name"
  type        = string
}

variable "alb_is_internal" {
  description = "Set ALB intrenal type, default value is False"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Load Balancer Type, default is aplication"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "Load Balancer Security Group"
  type        = string
}

variable "alb_subnets" {
  description = "public subnets to add alb"
  type        = list(any)
}

variable "default_http_listener_target_group_arn" {
  description = "ARN target group for default http listener"
  type        = string
}