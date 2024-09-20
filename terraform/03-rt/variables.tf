variable "vpc_id" {
  type        = string
  description = "The VPC ID where the subnet will be created"
}

variable "igw_id" {
  type = string
  description = "Internet Gateway Id"
}

variable "subnet_public_id" {
  type = string
  description = "Public subnet"
}

variable "subnet_private_id" {
  type = string
  description = "Public subnet"
}
variable "nat_gw_id" {
  type = string
  description = "Network Gateway Id"
}