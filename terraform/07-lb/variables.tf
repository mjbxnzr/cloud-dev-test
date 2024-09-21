variable "vpc_id" {
  type = string
}

variable "scg_nlb_id" {
  type = string
}

variable "subnet_ids" {
  type = list
  description = "Public subnet"
}
