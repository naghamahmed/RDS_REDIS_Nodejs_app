module "network" {
  source                     = "./modules/network"
  vpc_CIDR_block             = var.vpc_CIDR_block
  public-subnet1_CIDR_block  = var.public-subnet1_CIDR_block
  public-subnet2_CIDR_block  = var.public-subnet2_CIDR_block
  private-subnet1_CIDR_block = var.private-subnet1_CIDR_block
  private-subnet2_CIDR_block = var.private-subnet2_CIDR_block
  availability_zone_1        = var.availability_zone_1
  availability_zone_2        = var.availability_zone_2
}

# module "database" {
#   source = "./modules/Database"
#   SECURITY_GROUP_ID = module.network.SG_ID
#   RDS_USERNAME      = var.RDS_USERNAME
#   AZ                = var.availability_zone_1
#   DB_SUBNET_1       = module.network.private_subnet1_id
#   DB_SUBNET_2       = module.network.private_subnet2_id 
#   VPC_ID            = module.network.vpc_id
#   ec2_sg            = module.network.sg_2
# }