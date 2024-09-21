variable "image_id" {
  type = string
  description = "Image Id"
}

variable "ec2_type" {
  type = string
}

variable "ec2_private_subnet_cidrs" {
  type = string
}

variable "ec2_scg_name" {
  type = string
}

variable "ec2_name" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}