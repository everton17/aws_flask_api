output "abl_dns" {
  value = module.alb.alb-dns
}

output "ecr_repo_url" {
  value = module.ecr.ecr_repository_url
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}