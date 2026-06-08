# EC2 Module - Main Configuration

# Create EC2 Instance
resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip
  user_data                   = var.user_data
  
  # Root volume configuration
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true
    
    tags = merge(
      var.tags,
      {
        Name = "${var.instance_name}-root-volume"
      }
    )
  }
  
  # Enable detailed monitoring (optional)
  monitoring = true
  
  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
  
  # Ensure proper creation order
  depends_on = [var.vpc_security_group_ids]
}
