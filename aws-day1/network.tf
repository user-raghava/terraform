# VPC
resource "aws_vpc" "base" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }
}

# Subnets
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.base.id # Associate with the VPC
  cidr_block        = "192.168.0.64/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "web"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.base] # Ensure VPC is created first
}

resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.base.id
  cidr_block        = "192.168.0.128/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "app"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.base]
}

resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.base.id
  cidr_block        = "192.168.0.192/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "db"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.base]
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "from-tf-igw"
    Env  = "Dev"
  }
  depends_on = [aws_vpc.base]
}

# Route Tables
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public-rt"
    Env  = "Dev"
  }
  depends_on = [aws_internet_gateway.igw, aws_subnet.web] # Ensure IGW and subnet are created first
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private-rt"
    Env  = "Dev"
  }
  depends_on = [aws_subnet.app, aws_subnet.db] # Ensure subnets are created first
}

# Route Table Associations
resource "aws_route_table_association" "web_assoc" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.public_rt.id
  depends_on     = [aws_route_table.public_rt, aws_subnet.web] # Ensure both are created first
}

resource "aws_route_table_association" "app_assoc" {
  subnet_id      = aws_subnet.app.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_route_table.private_rt, aws_subnet.app]
}

resource "aws_route_table_association" "db_assoc" {
  subnet_id      = aws_subnet.db.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_route_table.private_rt, aws_subnet.db]
}

# Routes
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway.igw, aws_route_table.public_rt]
}