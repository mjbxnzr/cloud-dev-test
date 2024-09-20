# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "my_nat_eip" {
  vpc = true
}

# Main subnet
resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.16.0.0/24"
  availability_zone = var.az-1a

  tags = {
    Name = "MainSubnet"
  }
}

# Create an Internet Gateway for EC2 access to the internet
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

#################### MAIN ROUTE TABLE ####################
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.my_vpc.id  # Replace with your VPC ID

  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"  # The local route stays within the VPC
  }

  tags = {
    Name = "MainRouteTable"
  }
}

# Associate the route table with a subnet (optional, if required)
resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.main_subnet.id  # Replace with your subnet
  route_table_id = aws_route_table.main_route_table.id
}