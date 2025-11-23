# Create a VPC
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.10.0.0/16"

}

# Retrieve information about the VPC created above
data "aws_vpc" "test" {}

# Output the VPC ID
output "vpc_id" {
  value = data.aws_vpc.test.id
}