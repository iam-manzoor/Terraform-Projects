variable "applicationName" {
  description = "The name of the application to which the EC2 instance belongs."
  type        = string
}

variable "environment" {
  description = "The environment in which the EC2 instance will be deployed (e.g., dev, staging, prod)."
  type        = string
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the SSM endpoints will be created."
  type        = string
}

variable "region" {
  description = "The AWS region where the resources will be created."
  type        = string
}