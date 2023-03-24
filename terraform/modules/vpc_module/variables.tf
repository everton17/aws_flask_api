variable "region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project name, used for named vpc resources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "cidr block for vpc"
  type        = string
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  type        = number
  default     = 2
}

variable "environment" {
  description = "Env to deploy"
  type        = string
}