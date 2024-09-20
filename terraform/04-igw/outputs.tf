output "igw_id" {
  description = "The CIDR blocks of the subnets"
  value       = aws_internet_gateway.my_igw.id
}