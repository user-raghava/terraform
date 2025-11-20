variable "subscription_id" {
  type = string
}

variable "resource_group_info" {
  type = object({
    name             = string
    primary_region   = string
    secondary_region = string
  })
}

variable "primary_network_info" {
  type = object({
    name = string
    cidr = optional(string, "10.10.0.0/16")
    subnets = list(object({
      name = string
      cidr = string
    }))
  })
}
