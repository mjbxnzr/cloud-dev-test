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