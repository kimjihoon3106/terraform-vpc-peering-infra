resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.prefix}-vpc-B"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_block_private_a
  availability_zone = "${var.region}a"
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    "Name" = "${var.prefix}-private-subnet-vpc-B"
  }
}

resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.prefix}-private-rt-vpc-B"
  }
}

resource "aws_route_table_association" "private_subnet_route_association_a" {
  subnet_id = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}