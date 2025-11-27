variable "primary_vpc_info" {
  type = object({
    cidr                 = string
    enable_dns_hostnames = bool
    tags                 = map(string)
  })

}

variable "secondary_vpc_info" {
  type = object({
    cidr                 = string
    enable_dns_hostnames = bool
    tags                 = map(string)
  })

}


variable "region" {
  type = object({
    primary   = string
    secondary = string
  })
}

# primary VPC subnets
variable "primary_public_subnets" {
  type = list(object({
    az   = string
    cidr = string
    tags = map(string)
  }))
}

variable "primary_private_subnets" {
  type = list(object({
    az   = string
    cidr = string
    tags = map(string)
  }))
}

# secondary VPC subnets
variable "secondary_public_subnets" {
  type = list(object({
    az   = string
    cidr = string
    tags = map(string)
  }))
}

variable "secondary_private_subnets" {
  type = list(object({
    az   = string
    cidr = string
    tags = map(string)
  }))
}

variable "key_path" {
  type = string
}
