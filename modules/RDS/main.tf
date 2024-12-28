resource "aws_db_instance" "main" {
  identifier              = var.db_instance_identifier
  instance_class          = var.db_instance_class
  engine                  = var.engine
  engine_version          = var.engine_version
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name  # Changed 'name' to 'db_name'
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [var.security_group_id]
  multi_az                = true
  skip_final_snapshot     = true

  tags = {
    Name        = "RDS-${var.db_instance_identifier}"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "RDS-Subnet-Group-${var.environment}"
    Environment = var.environment
  }
}

