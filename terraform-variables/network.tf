# vpc creation
resource "aws_vpc" "base" {
  cidr_block           = var.vpc_info.cidr
  enable_dns_hostnames = var.vpc_info.enable_dns_hostnames
  tags                 = var.vpc_info.tags

}

# web subnet creation
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.base.id # implicit dependency
  availability_zone = var.web_subnet_info.az
  cidr_block        = var.web_subnet_info.cidr
  tags              = var.web_subnet_info.tags
  # explicit dependency
  depends_on = [aws_vpc.base]

}

# app subnet creation
resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.base.id # implicit dependency
  availability_zone = var.app_subnet_info.az
  cidr_block        = var.app_subnet_info.cidr
  tags              = var.app_subnet_info.tags
  # explicit dependency
  depends_on = [aws_vpc.base]

}

# db subnet creation
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.base.id # implicit dependency
  availability_zone = var.db_subnet_info.az
  cidr_block        = var.db_subnet_info.cidr
  tags              = var.db_subnet_info.tags
  # explicit dependency
  depends_on = [aws_vpc.base]

}