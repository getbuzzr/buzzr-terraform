# network acl where the webservers will exists
resource "aws_network_acl" "webserver" {
  vpc_id     = aws_default_vpc.default.id
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

}
# This is the nacl tcp rule for http traffic
module "webserver_http" {
  source = "../../modules/nacl_tcp_rule"

  network_acl_id = aws_network_acl.webserver.id
  from_port_number    = 80
  to_port_number    = 80
  rule_number    = 100
  cidr_block     = "0.0.0.0/0"
}

# This is the nacl tcp rule for https traffic
module "webserver_https" {
  source = "../../modules/nacl_tcp_rule"

  network_acl_id = aws_network_acl.webserver.id
  from_port_number    = 443
  to_port_number    = 443
  rule_number    = 200
  cidr_block     = "0.0.0.0/0"
}
# This is the nacl tcp rule for https traffic
module "webserver_ssh" {
  source = "../../modules/nacl_tcp_rule"

  network_acl_id = aws_network_acl.webserver.id
  from_port_number    = 22
  to_port_number    = 22
  rule_number    = 300
  cidr_block     = "0.0.0.0/0"
}
# This is the nacl tcp rule for https traffic
module "webserver_nat_gateway" {
  source = "../../modules/nacl_tcp_rule"

  network_acl_id = aws_network_acl.webserver.id
  from_port_number    = 1024
  to_port_number    = 65535
  rule_number    = 400
  cidr_block     = "0.0.0.0/0"
}



# network acl where the db will exists
resource "aws_network_acl" "db" {
  vpc_id     = aws_default_vpc.default.id
  subnet_ids = [aws_subnet.private3.id, aws_subnet.private4.id]

}
# This is the nacl rule for db traffic
module "db_aurora" {
  source = "../../modules/nacl_tcp_rule"

  network_acl_id = aws_network_acl.db.id
  from_port_number    = 3306
  to_port_number    = 3306
  rule_number    = 100
  cidr_block     = "0.0.0.0/0"
}
