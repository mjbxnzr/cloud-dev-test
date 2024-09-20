variable "vpc_id" {
  type        = string
  description = "The VPC ID where the subnet will be created"
}

variable "subnet_configs" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    map_public_ip_on_launch = bool
    name              = string
  }))
  description = "A list of subnet configurations"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
  default     = {}
}
