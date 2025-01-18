resource "aws_launch_configuration" "this" {
  name          = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = var.security_groups

  user_data = var.user_data

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.name
  }
}
