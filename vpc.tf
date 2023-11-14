##############################################################################################################
# VPC JUMPZONE
##############################################################################################################
resource "aws_vpc" "vpc_jumpzone" {
  cidr_block           = var.vpc_jumpzone_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.tag_name_prefix}-vpc_jumpzone"
  }
}

# IGW
resource "aws_internet_gateway" "igw_jumpzone" {
  vpc_id = aws_vpc.vpc_jumpzone.id
  tags = {
    Name = "${var.tag_name_prefix}-vpc-jumpzone-igw"
  }
}

# Subnets
resource "aws_subnet" "vpc_jumpzone_public_subnet" {
  vpc_id            = aws_vpc.vpc_jumpzone.id
  cidr_block        = var.vpc_jumpzone_public_subnet_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.tag_name_prefix}-vpc-jumpzone-public-subnet"
  }
}

# Routes
resource "aws_route_table" "jumpzone_public_rt" {
  vpc_id = aws_vpc.vpc_jumpzone.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_jumpzone.id
  }
  tags = {
    Name = "${var.tag_name_prefix}-vpc-jumpzone-public-rt"
  }
}

# Route tables associations
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.vpc_jumpzone_public_subnet.id
  route_table_id = aws_route_table.jumpzone_public_rt.id
}