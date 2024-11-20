output "vpc_c_id" {
  value = aws_vpc.vpc.id
}

output "vpc_c_route_table_id" {
  value = aws_route_table.private_route_table_a.id
}