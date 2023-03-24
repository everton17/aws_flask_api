output "abl_dns" {
  value = module.alb.alb-dns
}

output "ecr_repo_url" {
  value = module.ecr.ecr_repository_url
}

output "ecr_repo_code" {
  value = module.ecr.ecr_repo_path_login
}