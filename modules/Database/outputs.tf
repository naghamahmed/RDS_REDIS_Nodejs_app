output "RDS_HOSTNAME" {
    value = aws_db_instance.rds.address
}

output "REDIS_HOSTNAME"{
    value = aws_elasticache_cluster.elasticashe.cache_nodes.0.address
}

output "RDS_PASSWORD" {
    value = random_password.password.result
}
