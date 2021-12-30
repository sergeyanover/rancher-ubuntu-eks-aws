
output "ec2_public_ip" {
  value = aws_instance.eks_bastion.public_ip
}

