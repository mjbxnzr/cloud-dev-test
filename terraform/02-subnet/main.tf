

resource "aws_subnet" "this" {
  count             = length(var.subnet_configs)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_configs[count.index].cidr_block
  availability_zone = var.subnet_configs[count.index].availability_zone
  map_public_ip_on_launch = var.subnet_configs[count.index].map_public_ip_on_launch

  tags = merge({
    Name = var.subnet_configs[count.index].name
  }, var.tags)
}


# resource "aws_subnet" "public" {
#   count                   = 2
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = var.public_subnet_cidrs[count.index]
#   availability_zone       = var.availability_zones[count.index]
#   map_public_ip_on_launch = true
#
#   lifecycle {
#     create_before_destroy = true
#   }
#
#   tags = {
#     Name = "Public Subnet ${count.index + 1}"
#   }
# }
#
# resource "aws_subnet" "private" {
#   count                   = 2
#   vpc_id            = aws_vpc.my_vpc.id
#   cidr_block        = var.private_subnet_cidrs[count.index]
#   availability_zone = var.availability_zones[count.index]
#
#   lifecycle {
#     create_before_destroy = true
#   }
#   tags = {
#     Name = "Private Subnet ${count.index + 1}"
#   }
# }








