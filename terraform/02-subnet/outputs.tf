output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = aws_subnet.this[*].id
}

output "subnet_cidr_blocks" {
  description = "The CIDR blocks of the subnets"
  value       = aws_subnet.this[*].cidr_block
}
