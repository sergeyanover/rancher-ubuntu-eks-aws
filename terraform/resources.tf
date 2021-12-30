data "aws_ami" "latest_ubuntu_linux" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
    }
  owners = ["099720109477"]
}


resource "aws_key_pair" "ssh_key" {
  key_name = "eks-bastion"
  public_key = var.my_public_key
}



resource "aws_instance" "eks_bastion" {
  ami = data.aws_ami.latest_ubuntu_linux.id
  instance_type = "t2.medium"
  subnet_id = aws_subnet.eks_subnet_1.id
  vpc_security_group_ids = [aws_security_group.eks-bastion-sg.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true

  key_name = aws_key_pair.ssh_key.key_name


  user_data = file("bastion-entry-script.sh")


  tags = {
    Name = "eks-ec2-bastion"
  }
}


