# Security Groups Module - Main Configuration

# Public EC2 Security Group
resource "aws_security_group" "public" {
  name        = "nt548-public-sg"
  description = "Security group for public EC2 instance"
  vpc_id      = var.vpc_id
  
  # Allow SSH from specific IP
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
  
  # Allow HTTP from anywhere (optional, for web server)
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow HTTPS from anywhere (optional, for web server)
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(
    var.tags,
    {
      Name = "nt548-public-sg"
      Type = "Public"
    }
  )
}

# Private EC2 Security Group
resource "aws_security_group" "private" {
  name        = "nt548-private-sg"
  description = "Security group for private EC2 instance"
  vpc_id      = var.vpc_id
  
  # Allow SSH from public security group
  ingress {
    description     = "SSH from public EC2"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }
  
  # Allow ICMP (ping) from public security group
  ingress {
    description     = "ICMP from public EC2"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.public.id]
  }
  
  # Allow HTTP from public security group (optional)
  ingress {
    description     = "HTTP from public EC2"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }
  
  # Allow all outbound traffic (needed for NAT Gateway access)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(
    var.tags,
    {
      Name = "nt548-private-sg"
      Type = "Private"
    }
  )
}
