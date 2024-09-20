resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_route" "main_route_internet_access" {
  route_table_id         = var.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}