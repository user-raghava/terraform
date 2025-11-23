variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type = list(object({
    description = optional(string)
    cidr_ipv4   = string
    from_port   = number
    protocol = string # tcp/udp/icmp
    to_port     = number
  }))
}

variable "egress_rules" {
  type = list(object({
    description = optional(string)
    protocol = string
    cidr_ipv4   = string
  }))
  default = [
    {
      description = "Allow all outbound traffic"
      protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  ]
}

variable "tags" {
  type    = map(string)
  default = {}
}
