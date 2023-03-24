output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}

output "ecr_repo_path_login" {
  value = aws_ecr_repository.this.registry_id
}