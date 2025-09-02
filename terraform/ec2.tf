resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
}

resource "aws_instance" "bastion" {
  ami           = "ami-0933f1385008d33c4" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.bastion_key.key_name
  #security_groups = [aws_security_group.bastion_sg.name]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "resource_server" {
  ami           = "ami-0933f1385008d33c4"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  key_name      = aws_key_pair.bastion_key.key_name
  #security_groups = [aws_security_group.resource_sg.name]
  vpc_security_group_ids = [aws_security_group.resource_sg.id]

  tags = {
    Name = "Resource Server"
  }
}
