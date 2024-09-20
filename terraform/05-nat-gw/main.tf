

resource "aws_eip" "nat_gw" {
  count = 2
  domain = "vpc"

}

resource "aws_nat_gateway" "nat" {
  count         = 2
  allocation_id = aws_eip.nat_gw[count.index].id
  subnet_id     = var.subnets_public[count.index]
}

