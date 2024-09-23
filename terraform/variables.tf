variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "ami" {
  description = "Image id"
  default     = "ami-08569b978cc4dfa10"
}


variable "bucket_name" {
  description = "My bucket name"
  default     = "maybank-bucket-mujib-rahman"
}

variable "db_name" {
  description = "Database name"
  default     = "testing-my-bucket"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["192.168.5.0/24", "192.168.6.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["192.168.3.0/24", "192.168.4.0/24"]
}

variable "availability_zones" {
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}


variable "db_pass" {}

variable "db_user" {}