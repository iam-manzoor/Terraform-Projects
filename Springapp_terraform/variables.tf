variable cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable applicationName {
  type        = string
  default     = "SpringAppPetClinic"
  description = "We tie the VPC name with Application Name"
}

variable environment {
  type        = string
  default     = "Dev"
  description = "defines the environment"
}

variable common_tags {
  type        = map(string)
  default     = {
    Project     = "SpringAppPetClinic"
    Owner       = "Manzoor"
    CostCenter  = "CC1234"
  }
  description = "Common tags to be applied to all resources"
}

variable public_subnet_1 {
  type        = string
  default     = "10.0.1.0/24"
}

variable public_subnet_2 {
  type        = string
  default     = "10.0.2.0/24"
}

variable private_subnet_1 {
  type        = string
  default     = "10.0.3.0/24"
}

variable private_subnet_2 {
  type        = string
  default     = "10.0.4.0/24"
}

variable secure_subnet_1 {
  type        = string
  default     = "10.0.5.0/24"
}

variable secure_subnet_2 {
  type        = string
  default     = "10.0.6.0/24"
}