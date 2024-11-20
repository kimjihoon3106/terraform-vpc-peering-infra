resource "aws_vpc_peering_connection" "vpc_a_to_vpc_b" {
  peer_vpc_id = var.vpc_b_id
  vpc_id = var.vpc_a_id
  auto_accept = true

  tags = {
    Name = "vpc_a_to_vpc_b"
  }
}

resource "aws_vpc_peering_connection" "vpc_a_to_vpc_c" {
  peer_vpc_id = var.vpc_c_id
  vpc_id = var.vpc_a_id
  auto_accept = true

  tags = {
    Name = "vpc_a_to_vpc_c"
  }
}

resource "aws_vpc_peering_connection" "vpc_b_to_vpc_c" {
  peer_vpc_id = var.vpc_c_id
  vpc_id = var.vpc_b_id
  auto_accept = true

  tags = {
    Name = "vpc_b_to_vpc_c"
  }
}

# VPC A에서 VPC B로 라우팅
resource "aws_route" "route_a_to_b" {
  route_table_id         = var.vpc_a_route_table_id
  destination_cidr_block = "172.16.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_b.id
}

# VPC A에서 VPC C로 라우팅
resource "aws_route" "route_a_to_c" {
  route_table_id         = var.vpc_a_route_table_id
  destination_cidr_block = "192.168.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_c.id
}

# VPC B에서 VPC A로 라우팅
resource "aws_route" "route_b_to_a" {
  route_table_id         = var.vpc_b_route_table_id
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_b.id
}

# VPC B에서 VPC C로 라우팅
resource "aws_route" "route_b_to_c" {
  route_table_id         = var.vpc_b_route_table_id
  destination_cidr_block = "192.168.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_to_vpc_c.id
}

# VPC C에서 VPC A로 라우팅
resource "aws_route" "route_c_to_a" {
  route_table_id         = var.vpc_c_route_table_id
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_c.id
}

# VPC C에서 VPC B로 라우팅
resource "aws_route" "route_c_to_b" {
  route_table_id         = var.vpc_c_route_table_id
  destination_cidr_block = "172.16.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_to_vpc_c.id
}
