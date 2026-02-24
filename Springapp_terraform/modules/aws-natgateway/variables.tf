variable "applicationName" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "common_tags" {
  type        = map(string)
}

variable "internet_gateway_id" {
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "private_subnet_1_id" {
  type        = string
}

variable "private_subnet_2_id" {
  type        = string
}

variable "public_subnet_1_id" {
  type        = string
}

variable "public_subnet_2_id" {
  type        = string
}
