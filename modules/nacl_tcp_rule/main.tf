resource "aws_network_acl_rule" "default_egress" {
  network_acl_id = var.network_acl_id
  rule_number    = var.rule_number
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.cidr_block
  from_port      = var.from_port_number
  to_port        = var.to_port_number
}

resource "aws_network_acl_rule" "default_ingress" {
  network_acl_id = var.network_acl_id
  rule_number    = var.rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.cidr_block
  from_port      = var.from_port_number
  to_port        = var.to_port_number
}
