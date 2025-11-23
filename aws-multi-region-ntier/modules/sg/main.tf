resource "aws_security_group" "sg" {
  name   = var.name
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  count = length(var.ingress_rules)

  security_group_id = aws_security_group.sg.id

  description = var.ingress_rules[count.index].description
  cidr_ipv4   = var.ingress_rules[count.index].cidr_ipv4
  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  ip_protocol = var.ingress_rules[count.index].protocol
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  count = length(var.egress_rules)

  security_group_id = aws_security_group.sg.id

  description = var.egress_rules[count.index].description
  cidr_ipv4   = var.egress_rules[count.index].cidr_ipv4
  ip_protocol = var.egress_rules[count.index].protocol
}
