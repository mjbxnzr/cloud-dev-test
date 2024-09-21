# Security Group for EC2
resource "aws_security_group" "ec2_ssm_sg" {
  name_prefix = "instance-sg"
  vpc_id      = var.vpc_id
  description = "security group for the EC2 instance"

  # Allow outbound HTTPS traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable traffic to internet"
  }

  tags = {
    Name = "EC2 Instance security group"
  }
}

resource "aws_security_group" "ec2_private_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  egress {
    description = "Allow EC2 outbound traffic to MariaDB"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  }

  tags = {
    Name = "EC2SecurityGroup"
  }
}

# Security Group for RDS
resource "aws_security_group" "mariadb_sg" {
  vpc_id = var.vpc_id

  ingress {
    description      = "Allow MariaDB access from EC2 instances"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MariaDBSecurityGroup"
  }
}

# NLB
resource "aws_security_group" "nlb_security_group" {
  name        = "nlb-sg"
  description = "Security group for NLB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for VPC Endpoints
resource "aws_security_group" "vpc_endpoint_security_group" {
  name_prefix = "vpc-endpoint-sg"
  vpc_id      = var.vpc_id
  description = "security group for VPC Endpoints"

  # Allow inbound HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    description = "Allow HTTPS traffic from VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "VPC Endpoint security group"
  }
}