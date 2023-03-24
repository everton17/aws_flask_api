variable "ecr_name" {
  description = "Name of ECR Repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag imutability"
  type        = string
  default     = "MUTABLE"
}

variable "force_delete" {
  description = "Force delete repository on destroy"
  type        = string
  default     = "true"
}

variable "scan_on_push" {
  description = "Scannig image on push"
  type        = string
  default     = "true"
}