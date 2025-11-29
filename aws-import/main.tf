# VPC
resource "aws_vpc" "base" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  region               = "us-east-1"
  tags = {
    "Name" = "project-vpc"

  }
}
# Subnet
resource "aws_subnet" "public" {
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.144.0/20"
  vpc_id            = aws_vpc.base.id
  tags = {
    "Name" = "public"
  }
}
resource "aws_subnet" "app1" {
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.32.0/20"
  vpc_id            = aws_vpc.base.id
  tags = {
    "Name" = "app1"
  }
}
resource "aws_subnet" "app2" {
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.160.0/20"
  vpc_id            = aws_vpc.base.id
  tags = {
    "Name" = "app2"
  }
}
resource "aws_subnet" "db1" {
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.128.0/20"
  vpc_id            = aws_vpc.base.id
  tags = {
    "Name" = "db1"
  }
}
resource "aws_subnet" "db2" {
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.0.0/20"
  vpc_id            = aws_vpc.base.id
  tags = {
    "Name" = "db2"
  }
}

# internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags = {
    "Name" = "project-igw"
  }
}

# route tables
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "rt-private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "rt-public"
  }
}

# routes
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-0b4ce2925138a0530"
  route_table_id         = aws_route_table.public.id
}

# route table associations
resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.app1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.app2.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-3" {
  subnet_id      = aws_subnet.db1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-4" {
  subnet_id      = aws_subnet.db2.id
  route_table_id = aws_route_table.private.id
}

# security group
resource "aws_security_group" "web-sg" {
  name   = "web-sg"
  tags   = {}
  vpc_id = aws_vpc.base.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
  }
  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
}

# AWS EC2 Key Pair
resource "aws_key_pair" "ec2-key" {
  key_name   = "ec2-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# EC2 Instance
resource "aws_instance" "EC2Instance" {
    ami = "ami-0fa3fe0fa7920f68e"
    instance_type = "t2.micro"
    key_name = "ec2-key"
    availability_zone = "us-east-1a"
    subnet_id = aws_subnet.public.id
    ebs_optimized = false
    vpc_security_group_ids = [
        "${aws_security_group.web-sg.id}"
    ]
    root_block_device {
        volume_size = 8
        volume_type = "gp3"
        delete_on_termination = true
    }
    tags = {
        Name = "web1"
    }
}