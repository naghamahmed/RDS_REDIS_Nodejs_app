

# # create security group for the database
# resource "aws_security_group" "rds_security_group" {
#   name        = "rds security group"
#   description = "enable mysql access on port 3306"
#   vpc_id      = var.VPC_ID

#   ingress {
#     description      = "mysql access"
#     from_port        = "3306"
#     to_port          = "3306"
#     protocol         = "tcp"
#     security_groups  = [var.ec2_sg]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = -1
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags   = {
#     Name = "rds security group"
#   }
# }

# resource "aws_security_group" "redis_security_group" {
#   name        = "reds security group"
#   description = "enable redis access on port 6379"
#   vpc_id      = var.VPC_ID

#   ingress {
#     description      = "redis access"
#     from_port        = "6379"
#     to_port          = "6379"
#     protocol         = "tcp"
#     security_groups  = [var.ec2_sg]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = -1
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags   = {
#     Name = "redis security group"
#   }
# }


# # create the subnet group for the rds instance
# resource "aws_db_subnet_group" "database_subnet_group" {
#   name         = "db-subnets"
#   subnet_ids   = ["${var.DB_SUBNET_1}","${var.DB_SUBNET_2}"]
#   description  = "DB_SUBNET"

#   tags   = {
#     Name = "DB_SUBNET"
#   }
# }

# resource "random_password" "password" {
#   length           = 16
#   special          = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"

#   provisioner "local-exec" {
#     command = "export PASSWORD=${random_password.password.result}"
#   }
# }

# #create RDS mysql_db

# resource "aws_db_instance" "rds" {
#   identifier             = "rds-new"
#   allocated_storage      = 10
#   db_name                = "mydb"
#   engine                 = "mysql"
#   engine_version         = "5.7"
#   instance_class         = "db.t2.micro"
#   username               = var.RDS_USERNAME
#   password               = random_password.password.result
#   skip_final_snapshot    = true
#   port                   = 3306
#   availability_zone      = var.AZ
#   db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
#   vpc_security_group_ids = ["${aws_security_group.rds_security_group.id}"]
  
#   provisioner "local-exec" {
#     command = "export RDS_HOSTNAME=${self.address}"
#   }
# }


# resource "aws_elasticache_subnet_group" "redis_subnet" {
#   name       = "elasticache"
#   subnet_ids = ["${var.DB_SUBNET_1}","${var.DB_SUBNET_2}"]
# }

# #create Elasticashe redis_db

# resource "aws_elasticache_cluster" "elasticashe" {
#   cluster_id           = "cluster"
#   engine               = "redis"
#   node_type            = "cache.t2.micro"
#   num_cache_nodes      = 1
#   parameter_group_name = "default.redis3.2"
#   engine_version       = "3.2.10"
#   port                 = 6379
#   security_group_ids   = ["${aws_security_group.redis_security_group.id}"]
#   availability_zone    = var.AZ
#   subnet_group_name    = aws_elasticache_subnet_group.redis_subnet.name

#   provisioner "local-exec"{
#     command = "export REDIS_HOSTAME=${self.cache_nodes.0.address}"
#   }

# }