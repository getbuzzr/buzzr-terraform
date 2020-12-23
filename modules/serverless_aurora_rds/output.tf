output "arn" {
  value = aws_rds_cluster.default.arn
}

output "database_name" {
  value = aws_rds_cluster.default.database_name
}

output "master_username"{
  value = aws_rds_cluster.default.master_username
}

output "endpoint"{
  value = aws_rds_cluster.default.endpoint
}