# network acl where the webservers will exists
resource "aws_network_acl" "webserver" {
  vpc_id = aws_default_vpc.default.id
}
# This is the nacl tcp rule for http traffic
module "nacl_tcp_rule" "webserver_http" {
  network_acl_id = aws_network_acl.webserver.id
  port_number    = 80
  rule_number    = 100
  cidr_block     = "172.31.0.0/23"
}

# This is the nacl tcp rule for https traffic
module "nacl_tcp_rule" "webserver_https" {
  network_acl_id = aws_network_acl.webserver.id
  port_number    = 443
  rule_number    = 200
  cidr_block     = "172.31.0.0/23"
}


# network acl where the db will exists
resource "aws_network_acl" "db" {
  vpc_id = aws_default_vpc.default.id
}
# This is the nacl tcp rule for http traffic
module "nacl_tcp_rule" "webserver" {
  network_acl_id = aws_network_acl.db.id
  port_number    = 3306
  rule_number    = 100
  cidr_block     = "172.31.2.0/23"
}
