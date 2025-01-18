#modules include flags
include_vpc = false
include_ec2_instance = false
include_eks = false
include_rds = true
include_s3 = false
include_dynamodb = false

#region
region = "us-east-1"

#vpc values
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
environment = "dev"

#ec2 values
ami = "ami-0e2c8caa4b6378d8c"
instance_type = "t2.large"
autoscaling_min_size = 1
autoscaling_max_size = 3
autoscaling_desired_capacity = 1

#eks values
eks_cluster_name = "my-eks-cluster"
eks_node_group_name = "my-node-group"
eks_node_count = 2
eks_node_min_size = 1
eks_node_max_size = 3

#rds values
db_instance_identifier = "my-rds-instance"
db_instance_class = "db.t3.micro"
rds_engine = "mysql"
rds_engine_version = "8.0"
rds_allocated_storage = 20
rds_db_name = "mydatabase"
rds_username = "admin"
rds_password = "password123"

#s3 values
s3_bucket_name = "my-unique-bucket-name-siriparthi-2024"

#dynamodb values
dynamodb_table_name = "my-dynamodb-table"
dynamodb_read_capacity = 5
dynamodb_write_capacity = 5

 Load Balancer Configuration (if include_load_balancer is true)
load_balancer_name = "my-app-lb"
load_balancer_scheme = "internet-facing"  # or "internal"
load_balancer_listeners = [
  {
    port     = 80
    protocol = "HTTP"
    default_action = "forward" # Action when no rules match
  }
]

# CloudWatch Alarms Configuration (if include_cloudwatch is true)
cloudwatch_alarms = [
  {
    alarm_name                = "High-CPU-Utilization"
    comparison_operator       = "GreaterThanThreshold"
    evaluation_periods        = 2
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 80
    ok_actions               = ["arn:aws:sns:us-east-1:xxxxxxxxxxxx:my-sns-topic"]
    alarm_actions            = ["arn:aws:sns:us-east-1:xxxxxxxxxxxx:my-sns-topic"]
  },
  {
    alarm_name                = "Low-CPU-Utilization"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 2
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 10
    ok_actions               = ["arn:aws:sns:us-east-1:xxxxxxxxxxxx:my-sns-topic"]
    alarm_actions            = ["arn:aws:sns:us-east-1:xxxxxxxxxxxx:my-sns-topic"]
  }
]


# EC2 Configuration (if include_ec2_instance is true)
ami = "ami-0e2c8caa4b6378d8c"
instance_type = "t2.large"
instance_key_pair = "my-key-pair" # EC2 Key Pair Name
security_groups = ["sg-xxxxxxxx"] # Provide your security group ID here
user_data = <<-EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EOF

# Auto Scaling Configuration (if include_auto_scaling_group is true)
autoscaling_min_size = 1
autoscaling_max_size = 3
autoscaling_desired_capacity = 1


