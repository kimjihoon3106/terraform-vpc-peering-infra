module "vpc-A" {
  source = "./vpc-A"
  cidr_block = "10.0.0.0/16"
  cidr_block_public_a = "10.0.1.0/24"
  region = "ap-northeast-2"
  al2023_ami = data.aws_ami.al2023_ami
  prefix = "${var.prefix}-A"
}

module "vpc-B" {
  source = "./vpc-B"
  cidr_block = "172.16.0.0/16"
  cidr_block_private_a = "172.16.1.0/24"
  region = "ap-northeast-2"
  al2023_ami = data.aws_ami.al2023_ami
  prefix = "${var.prefix}-B"
}

module "vpc-C" {
  source = "./vpc-C"
  cidr_block = "192.168.0.0/16"
  cidr_block_private_a = "192.168.1.0/24"
  region = "ap-northeast-2"
  al2023_ami = data.aws_ami.al2023_ami
  prefix = "${var.prefix}-C"
}

module "vpc-peering" {
  source = "./vpc-peering"
  vpc_a_id = module.vpc-A.vpc_a_id
  vpc_b_id = module.vpc-B.vpc_b_id
  vpc_c_id = module.vpc-C.vpc_c_id

  vpc_a_route_table_id = module.vpc-A.vpc_a_route_table_id
  vpc_b_route_table_id = module.vpc-B.vpc_b_route_table_id
  vpc_c_route_table_id = module.vpc-C.vpc_c_route_table_id

  depends_on = [ 
    module.vpc-A,
    module.vpc-B,
    module.vpc-C,
   ]
}
