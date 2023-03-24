terraform {

  required_version = "1.3.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = ""
    key    = ""
    region = ""
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc_module"

  region         = var.region
  project_name   = var.project_name
  vpc_cidr_block = var.vpc_cidr_block
  environment    = var.environment
  az_count       = var.az_count
}

module "alb" {
  source = "./modules/alb_module"

  alb_name                               = var.alb_name
  security_groups                        = module.security_group.alb_security_group_id
  alb_subnets                            = module.vpc.public_subnets
  default_http_listener_target_group_arn = module.ecs.ecs_target_group_arn
}

module "security_group" {
  source = "./modules/security_groups_module"

  vpc_id   = module.vpc.vpc_id
  app_port = var.app_port
}

module "ecs" {
  source = "./modules/ecs_module"

  region                      = var.region
  vpc_id                      = module.vpc.vpc_id
  ecs_cluster_name            = var.ecs_cluster_name
  ecs_task_definition_name    = var.ecs_task_definition_name
  ecs_service_name            = var.ecs_service_name
  ecs_service_container_name  = var.ecs_service_container_name
  app_image                   = var.registry == "ecr" ? "${module.ecr.ecr_repository_url}:latest" : var.app_image
  app_port                    = var.app_port
  fargate_cpu                 = var.fargate_cpu
  fargate_memory              = var.fargate_memory
  ecs_service_security_group  = module.security_group.ecs_app_security_group_id
  ecs_service_subnets         = module.vpc.private_subnets
  ecs_target_group_name       = var.ecs_target_group_name
  ecs_target_healthcheck_path = var.ecs_target_healthcheck_path

  depends_on = [module.ecr]
}

module "ecr" {
  source = "./modules/ecr_module"

  ecr_name = var.ecr_registry_name
}