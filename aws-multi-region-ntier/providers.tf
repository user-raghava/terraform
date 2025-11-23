terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.21.0"
    }
  }
}

provider "aws" {
  alias  = "primary"          # alias for primary provider
  region = var.region.primary # use primary region from variables
}

provider "aws" {
  alias  = "secondary"
  region = var.region.secondary

}