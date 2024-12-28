provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
  environment = var.environment
  count = var.include_vpc ? 1 : 0
}

module "ec2_instance" {
  source = "./modules/ec2-instance"
  ami = var.ami
  instance_type = var.instance_type
  subnet_ids = module.vpc[0].public_subnet_ids
  security_group_id = module.vpc[0].security_group_id
  vpc_id = module.vpc[0].vpc_id
  environment = var.environment
  autoscaling_min_size = var.autoscaling_min_size
  autoscaling_max_size = var.autoscaling_max_size
  autoscaling_desired_capacity = var.autoscaling_desired_capacity
  http_port = 80
  count = var.include_ec2_instance ? 1 : 0
}

module "eks" {
  source = "./modules/EKS"
  cluster_name = var.eks_cluster_name
  node_group_name = var.eks_node_group_name
  node_count = var.eks_node_count
  node_min_size = var.eks_node_min_size
  node_max_size = var.eks_node_max_size
  vpc_id = module.vpc[0].vpc_id
  subnet_ids = module.vpc[0].private_subnet_ids
  environment = var.environment
  count = var.include_eks ? 1 : 0
}

module "rds" {
  source = "./modules/RDS"
  db_instance_identifier = var.db_instance_identifier
  db_instance_class = var.db_instance_class
  engine = var.rds_engine
  engine_version = var.rds_engine_version
  allocated_storage = var.rds_allocated_storage
  db_name = var.rds_db_name
  username = var.rds_username
  password = var.rds_password
  subnet_ids = module.vpc[0].private_subnet_ids
  security_group_id = module.vpc[0].security_group_id
  environment = var.environment
  count = var.include_rds ? 1 : 0
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.s3_bucket_name
  environment = var.environment
  count = var.include_s3 ? 1 : 0
}

module "dynamodb" {
  source = "./modules/DynamoDB"
  table_name = var.dynamodb_table_name
  read_capacity = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
  hash_key = var.dynamodb_hash_key
  range_key = var.dynamodb_range_key
  environment = var.environment
  count = var.include_dynamodb ? 1 : 0
}

