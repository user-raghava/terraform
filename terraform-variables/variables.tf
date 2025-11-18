# Variable definitions for Terraform configuration
# vpc information
variable "vpc_info" {
  type = object({
    cidr                 = string
    tags                 = map(string)
    enable_dns_hostnames = bool
  })
  description = "vpc information"
  default = {
    cidr = "192.168.0.0/16"
    tags = {
      Name = "from-tf"
      Env  = "Dev"
    }
    enable_dns_hostnames = true
  }

}

# AWS region
variable "region" {
  type    = string
  default = "ap-south-1"

}

# public subnets
variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "public subnets"

}

# private subnets
variable "private_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "private subnets"

}

# web security group information
variable "web_security_group_info" {
  type = object({
    name = string
    tags = map(string)
    ingress_rules = list(object({ #list of maps
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string # tcp/udp/icmp
      to_port     = number
    }))
    egress_rules = list(object({ # egress rules
      cidr_ipv4   = string
      ip_protocol = string
    }))
  })
}