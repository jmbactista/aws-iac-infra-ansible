resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Main-VPC"
  }
}

#PublicSub
resource "aws_subnet" "public_subnet" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = "10.0.1.0/24"
  availability_zone   = "ap-southeast-1a" 
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Sub"
  }
}

#PrivateSub
resource "aws_subnet" "private_subnet" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = "10.0.2.0/24"
  availability_zone   = "ap-southeast-1a"

  tags = {
    Name = "Private-Sub"
  }
}

#SG-Bastion
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion Security Group"
  }
}

#SG-Resource
resource "aws_security_group" "resource_sg" {
  name        = "resource-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    security_groups   = [aws_security_group.bastion_sg.id]    
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Resource Security Group"
  }
}
