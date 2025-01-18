resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = var.name
  }
}
