output "main_route_table_id" {
  description = "The CIDR blocks of the subnets"
  value       = aws_route_table.main_route_table.id
}