resource "aws_elasticache_cluster" "buzzr_redis" {
  cluster_id           = "buzzr-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnet_group.name
  apply_immediately    = true
  port                 = 6379
}
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "elasticache-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}
