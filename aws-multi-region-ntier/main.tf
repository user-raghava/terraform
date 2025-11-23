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