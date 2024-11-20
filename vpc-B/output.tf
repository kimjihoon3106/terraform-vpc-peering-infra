output "vpc_b_id" {
  value = aws_vpc.vpc.id
}

output "vpc_b_route_table_id" {
  value = aws_route_table.private_route_table_a.id
}