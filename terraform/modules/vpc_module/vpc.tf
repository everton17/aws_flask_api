# Get AZs in the current region
data "aws_availability_zones" "available" {
}

#VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    { Name = "VPC-${var.project_name}-${var.environment}" },
    local.common_tags
  )
}

#Subnets
resource "aws_subnet" "sn_private" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    { Name = "SN-PRIV-${data.aws_availability_zones.available.names[count.index]}-${var.environment}" },
    local.common_tags
  )
}

resource "aws_subnet" "sn_public" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    { Name = "SN-PUB-${data.aws_availability_zones.available.names[count.index]}-${var.environment}" },
    local.common_tags
  )
}


#IGW
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { Name = "IGW-${var.project_name}-${var.environment}" },
    local.common_tags
  )
}

#NATGW
resource "aws_eip" "natgw_ip" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  count         = var.az_count
  allocation_id = element(aws_eip.natgw_ip.*.id, count.index)
  subnet_id     = element(aws_subnet.sn_public.*.id, count.index)

  tags = merge(
    { Name = "NAT-GW-${var.project_name}-${var.environment}" },
    local.common_tags
  )

  depends_on = [aws_internet_gateway.this]
}

#RT
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    { Name = "RT-Public-${var.environment}" },
    local.common_tags
  )
}

resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.this.*.id, count.index)
  }

  tags = merge(
    { Name = "RT-Private-${var.environment}" },
    local.common_tags
  )
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.sn_public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.sn_private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}