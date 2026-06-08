# NAT Gateway Module - Main Configuration

# Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
  
  tags = merge(
    var.tags,
    {
      Name = "nt548-nat-eip"
    }
  )
}

# Create NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
  
  tags = merge(
    var.tags,
    {
      Name = "nt548-nat-gateway"
    }
  )
  
  # To ensure proper ordering, add an explicit dependency
  depends_on = [aws_eip.nat]
}
