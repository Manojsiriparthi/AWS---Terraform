resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  launch_configuration = var.launch_configuration_id
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = "EC2"
  health_check_grace_period = 300  # Wait 5 minutes before marking instances unhealthy

  load_balancers = var.load_balancer_ids

  target_group_arns = var.target_group_arns

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
