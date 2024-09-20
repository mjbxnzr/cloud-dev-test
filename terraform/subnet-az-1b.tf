
# Public subnet
resource "aws_subnet" "public_subnet_1b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.16.1.0/24"
  availability_zone = var.az-1b

  tags = {
    Name = "PublicSubnet-1b"
  }
}

# Private subnet
resource "aws_subnet" "private_subnet_1b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.16.2.0/24"
  availability_zone = var.az-1b

  tags = {
    Name = "PrivateSubnet-1b"
  }
}

# Create the NAT Gateway
resource "aws_nat_gateway" "my_nat_1b" {
  allocation_id = aws_eip.my_nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1b.id  # The NAT Gateway should be in a public subnet

  tags = {
    Name = "MyNATGateway"
  }
}

#################### PUBLIC ROUTE TABLE ####################
resource "aws_route_table" "public_route_table_1b" {
  vpc_id = aws_vpc.my_vpc.id

  # Route for VPC local traffic
  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"  # Local VPC route
  }

  # Route for Internet access (default route)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id  # Internet Gateway reference
  }

  tags = {
    Name = "PublicRouteTable-1b"
  }
}


resource "aws_route_table_association" "public_route_table_association_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route_table_1b.id
}


#################### PRIVATE ROUTE TABLE ####################
resource "aws_route_table" "private_route_table_1b" {
  vpc_id = aws_vpc.my_vpc.id

  # Route for VPC local traffic
  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"  # Local VPC route
  }

  # Route for Internet access (default route)
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_1b.id  # Internet Gateway reference
  }

  tags = {
    Name = "PrivateRouteTable-1b"
  }
}

resource "aws_route_table_association" "private_route_table_association_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_route_table_1b.id
}



