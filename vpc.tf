##############################################################################################################
# VPC jumpbox
##############################################################################################################
resource "aws_vpc" "vpc_jumpbox" {
  cidr_block           = var.vpc_jumpbox_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.tag_name_prefix}-vpc_jumpbox"
  }
}

# IGW
resource "aws_internet_gateway" "igw_jumpbox" {
  vpc_id = aws_vpc.vpc_jumpbox.id
  tags = {
    Name = "${var.tag_name_prefix}-vpc-jumpbox-igw"
  }
}

# Subnets
resource "aws_subnet" "vpc_jumpbox_public_subnet" {
  vpc_id            = aws_vpc.vpc_jumpbox.id
  cidr_block        = var.vpc_jumpbox_public_subnet_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.tag_name_prefix}-vpc-jumpbox-public-subnet"
  }
}

# Routes
resource "aws_route_table" "jumpbox_public_rt" {
  vpc_id = aws_vpc.vpc_jumpbox.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_jumpbox.id
  }
  tags = {
    Name = "${var.tag_name_prefix}-vpc-jumpbox-public-rt"
  }
}

# Route tables associations
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.vpc_jumpbox_public_subnet.id
  route_table_id = aws_route_table.jumpbox_public_rt.id
}