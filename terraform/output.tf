output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "resource_server_private_ip" {
  value = aws_instance.resource_server.private_ip
}
