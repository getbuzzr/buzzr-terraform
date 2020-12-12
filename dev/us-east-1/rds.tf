
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db"
  subnet_ids = [aws_subnet.private3.id, aws_subnet.private4.id]

  tags = {
    Name = "Private DB subnet"
  }
}


module "api_db_server" {
  source = "../../modules/serverless_aurora_rds"
  db_name = "onguardapi"
  db_subnet_group = aws_db_subnet_group.db_subnet_group.name
  db_password_ssm_path = "api_db_server_password"
  max_capacity_unit             = 1
}