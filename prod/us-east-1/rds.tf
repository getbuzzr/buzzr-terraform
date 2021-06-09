
data "aws_ssm_parameter" "db_server_password" {
  name = aws_ssm_parameter.api_db_server_password.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db"
  subnet_ids = [aws_subnet.private_webserver1.id, aws_subnet.private_webserver2.id]

  tags = {
    Name = "Private DB subnet"
  }
}
# create IAM role for monitoring
resource "aws_iam_role" "enhanced_monitoring" {
  name               = "enhanced-monitoring"
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json
}

# Attach Amazon's managed policy for RDS enhanced monitoring
resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = aws_iam_role.enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# allow rds to assume this role
data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
      actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "buzzr-api-${count.index}"
  cluster_identifier = aws_rds_cluster.prod_buzzr_aurora_cluster.id
  instance_class     = "db.t3.small"
  engine             = aws_rds_cluster.prod_buzzr_aurora_cluster.engine
  engine_version     = aws_rds_cluster.prod_buzzr_aurora_cluster.engine_version
  publicly_accessible=false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  monitoring_role_arn = aws_iam_role.enhanced_monitoring.arn
  monitoring_interval = 30
}

resource "aws_rds_cluster" "prod_buzzr_aurora_cluster" {
  cluster_identifier      = "buzzr-prod"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  database_name           = "buzzr"
  master_username         = "root"
  master_password         = data.aws_ssm_parameter.db_server_password.value
  backup_retention_period = 5
  preferred_backup_window = "02:00-05:00"
  apply_immediately=true
  db_subnet_group_name =aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot=true
  vpc_security_group_ids = [aws_security_group.db_server.id]
}

resource "aws_rds_cluster_endpoint" "buzzr_prod_endpoint" {
  cluster_identifier          = aws_rds_cluster.prod_buzzr_aurora_cluster.id
  cluster_endpoint_identifier = "buzzr-prod"
  custom_endpoint_type        = "ANY"

}