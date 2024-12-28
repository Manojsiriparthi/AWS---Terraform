output "db_instance_id" {
  value = aws_db_instance.main.id
}

output "db_name" {
  value = var.db_name  # Use the variable directly for the database name
}

output "db_hostname" {
  value = aws_db_instance.main.endpoint
}

