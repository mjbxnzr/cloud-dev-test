# resource "aws_lb_target_group" "tg" {
#   name     = "nlb-target-group"
#   port     = 80
#   protocol = "TCP"
#   vpc_id   = aws_vpc.my_vpc.id
#
# }
#
# resource "aws_lb" "nlb" {
#   name               = "nlb"
#   internal           = false
#   load_balancer_type = "network"
#   security_groups    = [aws_security_group.nlb_security_group.id]
#   subnets            = [aws_subnet.main_subnet.id]
#
#   enable_deletion_protection = false
# }
#
# resource "aws_lb_listener" "nlb_listener" {
#   load_balancer_arn = aws_lb.nlb.arn
#   port              = 80
#   protocol          = "TCP"
#
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn
#   }
# }