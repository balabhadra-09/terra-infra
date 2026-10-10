output "ec2_private_ips" {
  value = aws_instance.my_instance[*].private_ip
}

output "ec2_public_ips" {
  value = aws_instance.my_instance[*].public_ip
}
