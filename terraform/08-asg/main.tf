resource "aws_autoscaling_group" "autoscale" {
  name                  = "test-autoscaling-group"
  desired_capacity      = 3
  max_size              = 6
  min_size              = 3
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]
  vpc_zone_identifier   = var.asg_subnet_ids
  target_group_arns = [var.asg_lb_target_gp_arn]

  launch_configuration = aws_launch_configuration.terramino.name

#   launch_template {
#     id      = aws_launch_template.template.id
#     version = "$Latest"
#   }
}

resource "aws_launch_configuration" "terramino" {
  name   = "ec2-mbb-lb-1b"
  image_id      = var.image_id
  instance_type = var.ec2_type
  security_groups = [var.ec2_scg_id]

  lifecycle {
    create_before_destroy = true
  }
}
