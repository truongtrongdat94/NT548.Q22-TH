# Outputs for Terraform Configuration

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

# Subnet Outputs
output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

# Internet Gateway Output
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

# NAT Gateway Outputs
output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.nat_gateway.nat_gateway_id
}

output "nat_gateway_public_ip" {
  description = "Public IP of the NAT Gateway"
  value       = module.nat_gateway.nat_gateway_public_ip
}

# Route Table Outputs
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = module.vpc.private_route_table_id
}

# Security Group Outputs
output "public_security_group_id" {
  description = "ID of the public security group"
  value       = module.security_groups.public_sg_id
}

output "private_security_group_id" {
  description = "ID of the private security group"
  value       = module.security_groups.private_sg_id
}

# EC2 Outputs
output "public_ec2_instance_id" {
  description = "ID of the public EC2 instance"
  value       = module.ec2_public.instance_id
}

output "public_ec2_public_ip" {
  description = "Public IP of the public EC2 instance"
  value       = module.ec2_public.public_ip
}

output "public_ec2_private_ip" {
  description = "Private IP of the public EC2 instance"
  value       = module.ec2_public.private_ip
}

output "private_ec2_instance_id" {
  description = "ID of the private EC2 instance"
  value       = module.ec2_private.instance_id
}

output "private_ec2_private_ip" {
  description = "Private IP of the private EC2 instance"
  value       = module.ec2_private.private_ip
}

# SSH Connection Instructions
output "ssh_connection_instructions" {
  description = "Instructions for SSH connection"
  value = <<-EOT
    
    ====================================
    SSH CONNECTION INSTRUCTIONS
    ====================================
    
    1. Connect to Public EC2:
       ssh -i /path/to/${var.key_name}.pem ec2-user@${module.ec2_public.public_ip}
    
    2. From Public EC2, connect to Private EC2:
       ssh ec2-user@${module.ec2_private.private_ip}
    
    Note: Make sure to copy your private key to the Public EC2 instance first, or use SSH agent forwarding.
    
    ====================================
  EOT
}
