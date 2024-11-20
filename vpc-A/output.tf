output "vpc_a_id" {
  value = aws_vpc.vpc.id
}

output "vpc_a_route_table_id" {
  value = aws_route_table.public_route_table.id
}