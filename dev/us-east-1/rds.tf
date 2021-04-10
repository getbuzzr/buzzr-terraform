
data "aws_ssm_parameter" "api_db_server_password" {
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

module "api_db_server" {
  source               = "../../modules/serverless_aurora_rds"
  db_name              = "buzzrdev"
  db_subnet_group      = aws_db_subnet_group.elb_subnet_group.name
  db_password_ssm_path = "api_db_server_password"
  allowed_security_groups = [aws_security_group.db_server.id]
  max_capacity_unit    = 1
  
}


resource "aws_db_instance" "buzzrdev" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "buzzrdev"
  username             = "root"
  password             = data.aws_ssm_parameter.api_db_server_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}