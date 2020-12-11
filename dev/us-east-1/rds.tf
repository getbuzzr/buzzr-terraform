
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db"
  subnet_ids = [aws_subnet.private3.id, aws_subnet.private4.id]

  tags = {
    Name = "Private DB subnet"
  }
}


module "api_db_server" {
  db_name = "api_db_server"
  db_subnet_group = aws_db_subnet_group.db_subnet_group.name
  db_password_ssm_path = "api_db_server_password"
  max_capacity             = 1
}