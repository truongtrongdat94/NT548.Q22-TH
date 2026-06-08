# Security Groups Module - Outputs

output "public_sg_id" {
  description = "ID of the public security group"
  value       = aws_security_group.public.id
}

output "private_sg_id" {
  description = "ID of the private security group"
  value       = aws_security_group.private.id
}

output "public_sg_name" {
  description = "Name of the public security group"
  value       = aws_security_group.public.name
}

output "private_sg_name" {
  description = "Name of the private security group"
  value       = aws_security_group.private.name
}
