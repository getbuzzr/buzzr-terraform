module "nat" {
  source = "int128/nat-instance/aws"

  name                        = "main"
  vpc_id                      = aws_default_vpc.default.id
  public_subnet               = "172.31.0.0/24"
  private_subnets_cidr_blocks = ["172.31.2.0/24","172.31.3.0/24","172.31.4.0/24","172.31.5.0/24"]
  private_route_table_ids     = aws_route_table.private_route_table.id
}