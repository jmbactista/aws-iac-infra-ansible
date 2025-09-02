resource "aws_instance" "bastion" {
  ami           = "ami-0b3e5e8d5d8bcd15d" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.bastion_key.key_name
  security_groups = [aws_security_group.bastion_sg.name]

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "resource_server" {
  ami           = "ami-0b3e5e8d5d8bcd15d"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.resource_sg.name]

  tags = {
    Name = "Resource Server"
  }
}
