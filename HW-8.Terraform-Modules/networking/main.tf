# AWS VPC
resource "aws_vpc" "HD_Edu" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "HD-Edu"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.HD_Edu.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "eu-central-1a" # Change availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "HD-Edu-Public-Subnet"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.HD_Edu.id
  tags = {
    Name = "HD-Edu-Public-RT"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "HD_Edu_igw" {
  vpc_id = aws_vpc.HD_Edu.id
  tags = {
    Name = "HD-Edu-IGW"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Route for Internet Gateway
resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.HD_Edu_igw.id
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.HD_Edu.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = "eu-central-1b" # My availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "HD-Edu-Private-Subnet"
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.HD_Edu.id
  tags = {
    Name = "HD-Edu-Private-RT"
  }
}

resource "aws_eip" "nat_gateway_eip" {
  instance = null # EIP for NAT Gateway, not for instance
}
# NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# resource "aws_nat_gateway" "my_nat_gateway" {
#   allocation_id = aws_instance.nat_instance.id
#   subnet_id     = aws_subnet.public_subnet.id
# }

# Associate Route Table with Private Subnet
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Route for NAT Gateway
resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gateway.id
}
