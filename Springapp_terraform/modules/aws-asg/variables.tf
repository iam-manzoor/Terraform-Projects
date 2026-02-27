variable "applicationName" {
    type = string
}

variable "environment" {
    type = string
}

variable "common_tags" {
    type = map(string)
}

variable "private_subnet_1_id" {
    type = string
}

variable "private_subnet_2_id" {
    type = string
}

variable "application_load_balancer" {
    type = string
}

variable "iam_instance_profile_name" {
    type = string
}

variable "alb_security_group_id" {
    type = string
}

variable "alb_target_group_arn" {
    type = string
}

variable "rds_db_endpoint" {
    type = string
}
