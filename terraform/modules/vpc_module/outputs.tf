output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = [for subnet in aws_subnet.sn_public : subnet.id]
}

output "private_subnets" {
  value = [for subnet in aws_subnet.sn_private : subnet.id]
}