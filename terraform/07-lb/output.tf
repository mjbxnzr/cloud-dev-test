output "lb_target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}