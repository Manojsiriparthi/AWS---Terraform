variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "autoscaling_min_size" {
  description = "Minimum size for Auto Scaling group"
  type        = number
}

variable "autoscaling_max_size" {
  description = "Maximum size for Auto Scaling group"
  type        = number
}

variable "autoscaling_desired_capacity" {
  description = "Desired capacity for Auto Scaling group"
  type        = number
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "eks_node_count" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "eks_node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "eks_node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "Class of the RDS instance"
  type        = string
}

variable "rds_engine" {
  description = "Database engine"
  type        = string
}

variable "rds_engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = number
}

variable "rds_db_name" {
  description = "Name of the database"
  type        = string
}

variable "rds_username" {
  description = "Master username for the database"
  type        = string
}

variable "rds_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "dynamodb_read_capacity" {
  description = "Read capacity units for the DynamoDB table"
  type        = number
}

variable "dynamodb_write_capacity" {
  description = "Write capacity units for the DynamoDB table"
  type        = number
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
}

variable "dynamodb_range_key" {
  description = "Range key for the DynamoDB table"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "include_vpc" {
  description = "Include VPC module"
  type        = bool
}

variable "include_ec2_instance" {
  description = "Include EC2 Instance module"
  type        = bool
}

variable "include_eks" {
  description = "Include EKS module"
  type        = bool
}

variable "include_rds" {
  description = "Include RDS module"
  type        = bool
}

variable "include_s3" {
  description = "Include S3 module"
  type        = bool
}

variable "include_dynamodb" {
  description = "Include DynamoDB module"
  type        = bool
}

