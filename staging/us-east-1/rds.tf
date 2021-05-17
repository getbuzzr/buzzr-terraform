
data "aws_ssm_parameter" "db_server_password" {
  name = aws_ssm_parameter.api_db_server_password.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db"
  subnet_ids = [aws_subnet.private3.id, aws_subnet.private4.id]

  tags = {
    Name = "Private DB subnet"
  }
}
resource "aws_db_subnet_group" "elb_subnet_group" {
  name       = "db_public"
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Name = "public DB subnet"
  }
}


# resource "aws_db_instance" "buzzr_dev_staging" {
#   allocated_storage      = 10
#   identifier             = "buzzrstaging"
#   engine                 = "mysql"
#   engine_version         = "5.7"
#   instance_class         = "db.t3.micro"
#   name                   = "buzzr"
#   username               = "root"
#   password               = data.aws_ssm_parameter.db_server_password.value
#   parameter_group_name   = "default.mysql5.7"
#   skip_final_snapshot    = true
#   multi_az               = false
#   publicly_accessible    = true
#   db_subnet_group_name   = aws_db_subnet_group.elb_subnet_group.name
#   vpc_security_group_ids = [aws_security_group.public_access.id]
# }
