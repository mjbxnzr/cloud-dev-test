variable "asg_subnet_ids" {
  type = list
  description = "Private subnet 1b"
}

variable "asg_lb_target_gp_arn" {
  type = string
}

variable "ec2_scg_id" {
  type = string
}

variable "ec2_type" {
  type = string
}

variable "image_id" {
  type = string
}