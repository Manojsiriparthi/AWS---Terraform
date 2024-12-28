🚀 AWS Infrastructure Terraform Modules

This repository contains Terraform modules for creating and managing various AWS infrastructure components, including VPC, EC2 instances, EKS, RDS, S3, and DynamoDB. Each module is designed to be reusable and customizable for different environments (dev, staging, prod).


📦 Modules


🌐 VPC Module


The VPC module creates a Virtual Private Cloud (VPC) with public and private subnets, route tables, and an internet gateway.


Key Components:

    aws_vpc: Creates the main VPC with the specified CIDR block.

    aws_subnet: Creates public and private subnets within the VPC.

    aws_internet_gateway: Creates an internet gateway attached to the VPC.

    aws_route_table: Creates a route table for public subnets.

    aws_route: Adds a route for internet traffic to the internet gateway.

    aws_route_table_association: Associates the public subnets with the public route table.

    

💻 EC2 Module

The EC2 module creates an EC2 instance with specified configurations.



Key Components:

    aws_instance: Launches an EC2 instance using the provided AMI ID, instance type, subnet, and security group.

    tags: Tags are used to label resources for easier identification and management.

    

☸️ EKS Module


The EKS module sets up an Elastic Kubernetes Service (EKS) cluster with a node group.



Key Components:

    aws_eks_cluster: Creates the EKS cluster.

    aws_eks_node_group: Configures the node group for the EKS cluster, specifying the desired number of worker nodes and scaling parameters.

    

🗄️ RDS Module

The RDS module provisions a Relational Database Service (RDS) instance.



Key Components:

    aws_db_instance: Creates the RDS database instance with the specified configuration.

    aws_db_subnet_group: Groups the subnets used by the RDS instance for high availability.

    

🪣 S3 Module

The S3 module creates an S3 bucket with versioning enabled.


Key Components:
    
    aws_s3_bucket: Creates the S3 bucket with the specified name and ACL.

    aws_s3_bucket_versioning: Enables versioning for the S3 bucket.

    

🔢 DynamoDB Module


The DynamoDB module creates a DynamoDB table for use in state locking with Terraform.



Key Components:


    aws_dynamodb_table: Creates the DynamoDB table with specified read and write capacities and hash key.


🛠️ Explanation of Key Configurations

Conditional Resource Creation

    count = var.include_rds ? 1 : 0

    
This line is used to conditionally create resources based on a variable. If var.include_rds is true, the resource count is set to 1, meaning the resource will be created. If false, the count is set to 0, meaning the resource will not be created. This is useful for toggling resource creation based on environment or requirements.


Dynamic Length-Based Resource Creation

    count = length(var.public_subnet_cidrs)

    
This line dynamically creates resources based on the length of the list var.public_subnet_cidrs. For example, if there are two CIDR blocks in the list, two public subnets will be created. This approach is useful for scaling the infrastructure based on provided input.


Environment Variable Use

    environment = var.environment

    
This line assigns the value of var.environment to the environment parameter. It is commonly used for tagging resources to identify which environment (dev, staging, prod) the resource belongs to. This helps in managing resources across different environments and facilitates easier identification and filtering.



Availability Zone Specification

    availability_zone = element(var.availability_zones, count.index)

    
This line assigns a specific availability zone to a resource by using the element function. The count.index is used to select an availability zone from the list var.availability_zones. This ensures that resources are distributed across multiple availability zones for high availability and fault tolerance.



💡 Managing Different Workspaces

To manage different workspaces, you can set the appropriate module flags in your terraform.tfvars file. Here are some examples:



🛠️ Dev Workspace

If you are working in the dev workspace and need only EC2 and VPC, set the following flags in terraform.tfvars:


    include_vpc = true
    include_ec2_instance = true
    include_eks = false
    include_rds = false
    include_s3 = false
    include_dynamodb = false

    
🛠️ Prod Workspace

If you are working in the prod workspace and need only VPC and EKS cluster, set the following flags in terraform.tfvars:


    include_vpc = true
    include_ec2_instance = false
    include_eks = true
    include_rds = false
    include_s3 = false
    include_dynamodb = false
