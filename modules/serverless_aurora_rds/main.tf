data "aws_ssm_parameter" "api_db_server_password" {
  name = "api_db_server_password"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = var.db_name
  database_name      = var.db_name
  master_username    = "root"
  engine = "aurora"
  engine_mode          = "serverless"
  db_subnet_group_name = var.db_subnet_group
  master_password    = data.aws_ssm_parameter.api_db_server_password
  scaling_configuration {
    auto_pause               = true
    max_capacity             = var.max_capacity_unit
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}