variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC"
  default     = true
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
  default     = {}
}
