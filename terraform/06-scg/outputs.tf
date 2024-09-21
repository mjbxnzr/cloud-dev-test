output "mariadb_scg_id" {
  value = aws_security_group.mariadb_sg.id
}

output "ec2_private_scg_id" {
  value = aws_security_group.ec2_private_sg.id
}

output "ec2_private_scg_name" {
  value = aws_security_group.ec2_private_sg.name
}
output "nlb_security_group_id" {
  value = aws_security_group.nlb_security_group.id
}

output "vpc_endpoint_security_group_id" {
  value = aws_security_group.vpc_endpoint_security_group.id
}

output "ec2_ssm_sg_id" {
  value = aws_security_group.ec2_ssm_sg.id
}

output "ec2_ssm_sg_name" {
  value = aws_security_group.ec2_ssm_sg.name
}