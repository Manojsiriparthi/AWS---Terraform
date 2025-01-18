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
  environment = var.environment
  count = var.include_dynamodb ? 1 : 0
}

# Create Launch Configuration
module "launch_configuration" {
  source        = "./modules/launch_configuration"
  name          = var.launch_configuration_name
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = var.security_groups
  user_data     = var.user_data
}

# Create ALB
module "alb" {
  source         = "./modules/alb"
  name           = var.alb_name
  security_groups = var.security_groups
  subnet_ids     = var.subnet_ids
}

# Create Target Group
module "target_group" {
  source         = "./modules/target_group"
  name           = var.target_group_name
  port           = 80
  protocol       = "HTTP"
  vpc_id         = var.vpc_id
}

# Create Auto Scaling Group
module "autoscaling_group" {
  source              = "./modules/autoscaling_group"
  name                = var.asg_name
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  launch_configuration_id = module.launch_configuration.id
  subnet_ids          = var.subnet_ids
  load_balancer_ids   = [module.alb.id]
  target_group_arns   = [module.target_group.arn]
}

# Create CloudWatch Alarm
module "cloudwatch_alarm" {
  source           = "./modules/cloudwatch"
  alarm_name       = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name      = "CPUUtilization"
  namespace        = "AWS/EC2"
  period           = 60
  statistic        = "Average"
  threshold        = 80
  asg_name         = module.autoscaling_group.asg_name
  ok_actions       = []
  alarm_actions    = [var.sns_topic_arn]
}

