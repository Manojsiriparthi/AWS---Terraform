variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
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

variable "http_port" {
  description = "HTTP port for user_data"
  type        = number
  default     = 80
}

