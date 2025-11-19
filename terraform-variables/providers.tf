terraform {
  required_version = ">= 1.11.0" # specify terraform version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0" # >= greater than equal to 6.0.0
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
