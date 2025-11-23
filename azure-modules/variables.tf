variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "location" {
  type = object({
    primary   = string
    secondary = string
  })
}