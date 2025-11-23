module "primary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.primary # use the primary provider
  }
  vpc_info = {
    cidr                 = var.vpc_cidrs.primary
    enable_dns_hostnames = true
    tags = {
      Name = "primary"
    }
  }

  public_subnets = var.primary_public_subnets

  private_subnets = var.primary_private_subnets

}


module "secondary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.secondary
  }
  vpc_info = {
    cidr                 = var.vpc_cidrs.secondary
    enable_dns_hostnames = true
    tags = {
      Name = "secondary"
    }
  }

  public_subnets = var.secondary_public_subnets

  private_subnets = var.secondary_private_subnets
}

module "primary_sg" {
  source = "./modules/sg"
  providers = {
    aws = aws.primary
  }

  name   = "web-sg"
  vpc_id = module.primary_vpc.vpc_id

  ingress_rules = [
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    },
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]

  tags = {
    Name        = "Web SG"
    Environment = "dev"
  }
}

module "secondary_sg" {
  source = "./modules/sg"
  providers = {
    aws = aws.secondary
  }

  name   = "web-sg"
  vpc_id = module.secondary_vpc.vpc_id

  ingress_rules = [
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    },
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]

  tags = {
    Name        = "Web SG"
    Environment = "dev"
  }
}