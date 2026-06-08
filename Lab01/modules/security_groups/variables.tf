# Security Groups Module - Variables

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "my_ip" {
  description = "Your IP address for SSH access (format: x.x.x.x/32)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
