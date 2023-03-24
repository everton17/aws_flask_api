resource "aws_ecr_repository" "this" {
  name                 = var.ecr_name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(
    { Name = var.ecr_name },
    local.common_tags
  )
}