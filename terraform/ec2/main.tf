resource "aws_instance" "my_ec2_1a" {
  ami           = var.image_id  # Amazon Linux 2 AMI
  instance_type = var.ec2_type
  subnet_id     = var.ec2_private_subnet_cidrs
  security_groups = [var.ec2_scg_name]

  tags = {
    Name = var.ec2_name
  }
}