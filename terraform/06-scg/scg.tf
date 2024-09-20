# # Security Group for EC2
# resource "aws_security_group" "ec2_sg" {
#   vpc_id = aws_vpc.my_vpc.id
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
#   }
#
#   egress {
#     description = "Allow EC2 outbound traffic to MariaDB"
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#   }
#
#   tags = {
#     Name = "EC2SecurityGroup"
#   }
# }
#
# # Security Group for RDS
# resource "aws_security_group" "mariadb_sg" {
#   vpc_id = aws_vpc.my_vpc.id
#
#   ingress {
#     description      = "Allow MariaDB access from EC2 instances"
#     from_port        = 3306
#     to_port          = 3306
#     protocol         = "tcp"
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "MariaDBSecurityGroup"
#   }
# }
#
# # NLB
# resource "aws_security_group" "nlb_security_group" {
#   name        = "nlb-sg"
#   description = "Security group for NLB"
#   vpc_id      = aws_vpc.my_vpc.id
#
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }