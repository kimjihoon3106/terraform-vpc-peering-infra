resource "aws_security_group" "private_instance_sg" {
  name = "${var.prefix}-public-instance-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = -1
  }
}

resource "aws_instance" "bastion" {
  ami = var.al2023_ami.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_subnet_a.id
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]

  key_name = "skill"

  tags = {
      "Name" = "${var.prefix}-public-insatnce-B"
    }
}