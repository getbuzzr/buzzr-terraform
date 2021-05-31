
data "aws_ssm_parameter" "db_server_password" {
  name = aws_ssm_parameter.api_db_server_password.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db"
  subnet_ids = [aws_subnet.private_db1.id, aws_subnet.private_db2.id]

  tags = {
    Name = "Private DB subnet"
  }
}

module "buzzr_prod_db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "5.2.0"

  name           = "buzzr"
  engine         = "aurora-mysql"
  engine_version = "5.7"
  instance_type  = "db.t3.small"

  vpc_id  = aws_default_vpc.default.id
  subnets = [aws_subnet.private_db1.id, aws_subnet.private_db2.id]

  replica_count           = 1
  allowed_security_groups = [aws_security_group.db_server.id]
  allowed_cidr_blocks     = ["172.31.4.0/24","172.31.5.0/24"]
  database_name                   = "buzzr"
  username               = "root"
  password               = data.aws_ssm_parameter.db_server_password.value
  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["mysql"]

  tags = {
    Environment = "prod"
    Terraform   = "true"
  }
}


resource "aws_db_instance" "buzzr_db" {
  allocated_storage      = 10
  identifier             = "buzzr"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "buzzr"
  username               = "root"
  password               = data.aws_ssm_parameter.db_server_password.value
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  multi_az               = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_server.id]
}
