resource "aws_vpc" "eks_vpc" {
  cidr_block       = var.eks_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "eks_vpc"
  }
}

resource "aws_subnet" "eks_subnet_1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet1_cidr
  availability_zone = var.avail_zone

  tags = {
    Name = "eks_subnet1"
  }
}

resource "aws_subnet" "eks_subnet_private1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet_private1_cidr
  availability_zone = var.avail_zone

  tags = {
    Name = "eks_subnet_private1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "eks_subnet_private2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet_private2_cidr
  availability_zone = var.avail_zone2

  tags = {
    Name = "eks_subnet_private2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "eks_subnet_private3" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet_private3_cidr
  availability_zone = var.avail_zone3

  tags = {
    Name = "eks_subnet_private3"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "eks_subnet_public1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet_public1_cidr
  availability_zone = var.avail_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "eks_subnet_public1"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "eks_subnet_public2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet_public2_cidr
  availability_zone = var.avail_zone2
  map_public_ip_on_launch = true

  tags = {
    Name = "eks_subnet_public2"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "eks_subnet_public3" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.eks_subnet_public3_cidr
  availability_zone = var.avail_zone3
  map_public_ip_on_launch = true

  tags = {
    Name = "eks_subnet_public3"
    "kubernetes.io/role/elb" = "1"
  }
}


resource "aws_internet_gateway" "eks_igw" {
  vpc_id     = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks_igw"
  }  
}

resource "aws_default_route_table" "eks_rtb" {
  default_route_table_id = aws_vpc.eks_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }  
  tags = {
    Name = "eks_rtb"
  }  
}