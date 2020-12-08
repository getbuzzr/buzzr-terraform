resource "aws_network_acl_rule" "default" {
  network_acl_id = var.network_acl_id
  rule_number    = var.rule_number
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.cidr_block
  from_port      = var.port_number
  to_port        = var.port_number
}
