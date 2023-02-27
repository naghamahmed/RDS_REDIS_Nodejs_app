resource "aws_ssm_parameter" "rds_hostname" {
  name        = "/dev/database/hostname"
  description = "rds_hostname"
  type        = "SecureString"
  value       = aws_db_instance.rds.address
}

resource "aws_ssm_parameter" "redis_hostname" {
  name        = "/dev/redis/hostname"
  description = "redis_hostname"
  type        = "SecureString"
  value       = aws_elasticache_cluster.elasticashe.cache_nodes.0.address
}

resource "aws_ssm_parameter" "database_password" {
  name        = "/dev/database/password"
  description = "redis_password"
  type        = "SecureString"
  value       = random_password.password.result
}
