# region variable with default value
variable "region" {
  type    = string
  default = "ap-south-1"

}

# vpc information variable
variable "vpc_info" {
  type = object({ # vpc information as object type
    cidr                 = string
    tags                 = map(string) # tags as map type
    enable_dns_hostnames = bool
  })
  description = "vpc information"

  default = { # default vpc information
    cidr = "192.168.0.0/24"
    tags = {
      Name = "from-tf"
      Env  = "Dev"
    }
    enable_dns_hostnames = true
  }

}

# web subnet information variable
variable "web_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.0.0/24"
    tags = {
      Name = "web"
      Env  = "Dev"
    }
  }
  description = "web subnet information"

}

# App Subnet Variables
variable "app_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1b"
    cidr = "192.168.0.64/26"
    tags = {
      Name = "app"
      Env  = "Dev"
    }
  }
  description = "app subnet information"
}

# DB Subnet Variables
variable "db_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1c"
    cidr = "192.168.0.128/26"
    tags = {
      Name = "db"
      Env  = "Dev"
    }
  }
  description = "db subnet information"
}
