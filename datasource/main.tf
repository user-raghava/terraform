resource "aws_vpc" "test_vpc" {
  cidr_block = "10.10.0.0/16"

}

# Retrieve information about the VPC created above
data "aws_vpc" "test" {}

