terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.21.0"
    }
  }
  # State management in S3 centralized backend
  backend "s3" {
    bucket       = "<S3-BUCKET-NAME>"
    key          = "projects/multiregion/aws"
    region       = "us-east-1"
    use_lockfile = true # prevents users from "terraform apply" simultaneously
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