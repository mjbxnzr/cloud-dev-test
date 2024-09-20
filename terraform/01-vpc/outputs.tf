output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.my_vpc.cidr_block
}
