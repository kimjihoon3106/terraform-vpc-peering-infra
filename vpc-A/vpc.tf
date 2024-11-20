resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.prefix}-vpc-A"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.prefix}-igw-vpc-A"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_block_public_a
  availability_zone = "${var.region}a"
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.prefix}-public-subnet-vpc-A"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    "Name" = "${var.prefix}-public-rt-vpc-A"
  }
}

resource "aws_route_table_association" "public_subnet_route_association_a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}