variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "ami" {
  description = "Image id"
  default     = "ami-0c55b159cbfafe1f0"
}
variable "az-1a" {
  description = "The AWS region"
  default     = "us-east-1a"
}

variable "az-1b" {
  description = "The AWS region"
  default     = "us-east-1b"
}

variable "bucket_name" {
  description = "My bucket name"
  default     = "testing-my-bucket"
}

variable "db_name" {
  description = "Database name"
  default     = "testing-my-bucket"
}

# variable "vpc_cidr" {
#   default = "192.168.0.0/16"
# }
#
# variable "public_subnet_cidrs" {
#   default = ["192.168.5.0/24", "192.168.6.0/24"]
# }
#
# variable "private_subnet_cidrs" {
#   default = ["192.168.3.0/24", "192.168.4.0/24"]
# }

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}
