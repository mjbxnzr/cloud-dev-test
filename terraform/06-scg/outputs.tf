output "mariadb_scg_id" {
  value = aws_security_group.mariadb_sg.id
}

output "ec2_scg_id" {
  value = aws_security_group.ec2_sg.id
}

output "ec2_scg_name" {
  value = aws_security_group.ec2_sg.name
}
output "nlb_security_group_id" {
  value = aws_security_group.nlb_security_group.id
}