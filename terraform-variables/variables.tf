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
# region variable
variable "region" {
  type    = string
  default = "ap-south-1"

}

# public subnet variable
variable "public_subnets" {
  type = list(object({ # list of objects
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "public subnets"

}

# private subnet variable
variable "private_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "private subnets"

}
