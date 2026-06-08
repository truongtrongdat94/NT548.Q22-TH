# NAT Gateway Module - Variables

variable "public_subnet_id" {
  description = "ID of the public subnet where NAT Gateway will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
