# Invoke VPC Module
module "vpc" {
  source = "./modules/aws-vpc"
  applicationName = var.applicationName
  environment = var.environment
  common_tags = var.common_tags
  cidr_block = var.cidr_block
  public_subnet_1 = var.public_subnet_1
  public_subnet_2 = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
  secure_subnet_1 = var.secure_subnet_1
  secure_subnet_2 = var.secure_subnet_2
}

# Invoke NAT Gateway Module

module "natgateway" {
  source = "./modules/aws-natgateway"
  applicationName = var.applicationName
  environment = var.environment
  common_tags = var.common_tags
  internet_gateway_id = module.vpc.internet_gateway_id
  vpc_id = module.vpc.vpc_id
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
}