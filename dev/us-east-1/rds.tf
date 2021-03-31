
resource "aws_db_subnet_group" "elb_subnet_group" {
  name       = "db"
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Name = "Public DB subnet"
  }
}


module "api_db_server" {
  source               = "../../modules/serverless_aurora_rds"
  db_name              = "buzzrdev"
  db_subnet_group      = aws_db_subnet_group.elb_subnet_group.name
  db_password_ssm_path = "api_db_server_password"
  allowed_security_groups = [aws_security_group.db_server.id]
  max_capacity_unit    = 1
}