resource "aws_launch_configuration" "main" {
  name          = "${var.environment}-launch-configuration-${replace(timestamp(), ":", "-")}"
  image_id      = var.ami
  instance_type = var.instance_type
  security_groups = [var.security_group_id]

  root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              EOF

  depends_on = [aws_iam_instance_profile.main]
}

resource "aws_autoscaling_group" "main" {
  launch_configuration = aws_launch_configuration.main.id
  min_size             = var.autoscaling_min_size
  max_size             = var.autoscaling_max_size
  desired_capacity     = var.autoscaling_desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = [aws_lb_target_group.main.arn]

  tag {
    key                 = "Name"
    value               = "${var.environment}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.main]
}

resource "aws_lb" "main" {
  name               = "${var.environment}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.environment}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.environment}-instance-profile"

  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  name               = "${var.environment}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

