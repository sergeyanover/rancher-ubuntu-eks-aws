resource "aws_default_security_group" "eks-default-sg" {
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


resource "aws_security_group" "eks-bastion-sg" {
  name        = "allow_inbound_bastion"
  description = "Allow Inbound traffic"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ip_admin]
  }

  ingress {
    description      = "SSH 12000"
    from_port        = 12000
    to_port          = 12000
    protocol         = "tcp"
    cidr_blocks      = [var.ip_admin]
  }

  ingress {
    description      = "Traffic from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.eks_vpc_cidr]
  }

  ingress {
    description      = "Rancher 80 port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.ip_admin]
  }

  ingress {
    description      = "Rancher 443 port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_inbound_bastion"
  }
}



resource "aws_security_group" "eks-rancher-sg" {
  name        = "allow_inbound_from_rancher"
  description = "Allow Inbound traffic from Rancher"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description      = "Traffic from Rancher"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.eks_subnet1_cidr]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_inbound_from_rancher"
  }
}
