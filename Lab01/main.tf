# Main Terraform Configuration
# NT548 - Lab 01: AWS Infrastructure Deployment

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "NT548-Lab01"
      Environment = "Development"
      ManagedBy   = "Terraform"
    }
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  
  tags = {
    Name = "nt548-vpc"
  }
}

# NAT Gateway Module
module "nat_gateway" {
  source = "./modules/nat_gateway"
  
  public_subnet_id = module.vpc.public_subnet_id
  
  tags = {
    Name = "nt548-nat-gateway"
  }
}

# Update Private Route Table with NAT Gateway
resource "aws_route" "private_nat_gateway" {
  route_table_id         = module.vpc.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.nat_gateway.nat_gateway_id
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security_groups"
  
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
  
  tags = {
    Environment = "Development"
  }
}

# EC2 Module - Public Instance
module "ec2_public" {
  source = "./modules/ec2"
  
  instance_name            = "nt548-public-ec2"
  ami_id                   = var.ami_id
  instance_type            = var.instance_type
  subnet_id                = module.vpc.public_subnet_id
  vpc_security_group_ids   = [module.security_groups.public_sg_id]
  key_name                 = var.key_name
  associate_public_ip      = true
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>NT548 - Public EC2 Instance</h1>" > /var/www/html/index.html
              EOF
  
  tags = {
    Name = "nt548-public-ec2"
    Type = "Public"
  }
}

# EC2 Module - Private Instance
module "ec2_private" {
  source = "./modules/ec2"
  
  instance_name            = "nt548-private-ec2"
  ami_id                   = var.ami_id
  instance_type            = var.instance_type
  subnet_id                = module.vpc.private_subnet_id
  vpc_security_group_ids   = [module.security_groups.private_sg_id]
  key_name                 = var.key_name
  associate_public_ip      = false
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>NT548 - Private EC2 Instance</h1>" > /var/www/html/index.html
              EOF
  
  tags = {
    Name = "nt548-private-ec2"
    Type = "Private"
  }
}
