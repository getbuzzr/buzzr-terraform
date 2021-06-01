
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
# module "buzzr_prod_db" {
#   source  = "terraform-aws-modules/rds-aurora/aws"
#   version = "5.2.0"

#   name           = "buzzr"
#   engine         = "aurora-mysql"
#   engine_version = "5.7"
#   instance_type  = "db.t3.small"

#   vpc_id  = aws_default_vpc.default.id
#   subnets = [aws_subnet.private_db1.id, aws_subnet.private_db2.id]

#   replica_count           = 1
#   allowed_security_groups = [aws_security_group.db_server.id]
#   allowed_cidr_blocks     = ["172.31.4.0/24","172.31.5.0/24"]
#   database_name                   = "buzzr"
#   username               = "root"
#   password               = data.aws_ssm_parameter.db_server_password.value
#   storage_encrypted   = true
#   apply_immediately   = true
#   monitoring_interval = 10

#   db_parameter_group_name         = "default"
#   db_cluster_parameter_group_name = "default"

#   enabled_cloudwatch_logs_exports = ["mysql"]

#   tags = {
#     Environment = "prod"
#     Terraform   = "true"
#   }
# }

# module "buzzr_prod_db" {
#   source = "cloudposse/rds-cluster/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   version     = "0.45.0"
#   engine          = "aurora"
#   cluster_family  = "aurora-mysql5.7"
#   cluster_size    = 2
#   namespace       = "bz"
#   stage           = "prod"
#   name            = "buzzr"
#   admin_user      = "root"
#   admin_password  = data.aws_ssm_parameter.db_server_password.value
#   db_name         = "buzzr"
#   instance_type   = "db.t2.small"
#   vpc_id          = aws_default_vpc.default.id
#   security_groups = [aws_security_group.db_server.id]
#   subnets         = [aws_subnet.private_db1.id, aws_subnet.private_db2.id]
#   backup_window= "1:00-3:00"
#   # enable monitoring every 30 seconds
#   rds_monitoring_interval = 30

#   # reference iam role created above
#   rds_monitoring_role_arn = aws_iam_role.enhanced_monitoring.arn
# }

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "buzzr-api-${count.index}"
  cluster_identifier = aws_rds_cluster.buzzr_cluster.id
  instance_class     = "db.t3.small"
  engine             = aws_rds_cluster.buzzr_cluster.engine
  engine_version     = aws_rds_cluster.buzzr_cluster.engine_version
  publicly_accessible=true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  monitoring_role_arn = aws_iam_role.enhanced_monitoring.arn
  monitoring_interval = 30
}

resource "aws_rds_cluster" "buzzr_cluster" {
  cluster_identifier      = "buzzr"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["us-east-1d", "us-east-1c"]
  database_name           = "buzzr"
  master_username         = "root"
  master_password         = data.aws_ssm_parameter.db_server_password.value
  backup_retention_period = 5
  preferred_backup_window = "02:00-05:00"
  apply_immediately=true
  db_subnet_group_name =aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot=true
}