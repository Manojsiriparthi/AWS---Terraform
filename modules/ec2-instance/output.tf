output "launch_configuration_id" {
  value = aws_launch_configuration.main.id
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.main.id
}

output "load_balancer_arn" {
  value = aws_lb.main.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

