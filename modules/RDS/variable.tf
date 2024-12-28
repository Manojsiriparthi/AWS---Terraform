variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "Class of the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
}

variable "engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = number
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the RDS instance"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

