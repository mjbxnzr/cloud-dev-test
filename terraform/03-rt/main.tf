#
resource "aws_route_table" "main_route_table" {
  vpc_id = var.vpc_id  # Replace with your VPC ID

#   route {
#     cidr_block = "192.168.0.0/16"
#     gateway_id = "local"  # The local route stays within the VPC
#   }

  tags = {
    Name = "MainRouteTable"
  }
}

# Associate the route table with a subnet (optional, if required)
resource "aws_main_route_table_association" "main_route_table_association" {
  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.main_route_table.id
}
#
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  # Route for Internet access (default route)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id # Internet Gateway reference
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = var.subnet_public_id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  # Route for Internet access (default route)
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id # Nat Gateway reference
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = var.subnet_private_id
  route_table_id = aws_route_table.private_route_table.id
}
