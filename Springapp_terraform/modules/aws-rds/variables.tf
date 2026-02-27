variable "vpc_id" {}
variable "secure_subnet_1" {}
variable "secure_subnet_2" {}
variable "alb_security_group_id" {}
variable "common_tags" {
    type = map(string)
}