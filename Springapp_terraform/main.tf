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

module "security_group" {
  source = "./modules/aws-securityGroup"
  vpc_id = module.vpc.vpc_id
  applicationName = var.applicationName
  environment = var.environment
  common_tags = var.common_tags
}

module "ssm_ec2" {
  source = "./modules/aws-ssm-ec2"
  applicationName = var.applicationName
  environment = var.environment
  common_tags = var.common_tags
  vpc_id = module.vpc.vpc_id
  region = var.region
}

module "alb" {
  source = "./modules/aws-alb"
  applicationName = var.applicationName
  environment = var.environment
  common_tags = var.common_tags
  vpc_id = module.vpc.vpc_id
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  alb_security_group_id = module.security_group.security_group_id
}

module "rds" {
  source = "./modules/aws-rds"
  common_tags = var.common_tags
  vpc_id = module.vpc.vpc_id
  secure_subnet_1 = module.vpc.secure_subnet_1_id
  secure_subnet_2 = module.vpc.secure_subnet_2_id
  alb_security_group_id = module.security_group.security_group_id
}

module "asg" {
  source = "./modules/aws-asg"
  applicationName = var.applicationName
  environment = var.environment
  common_tags = var.common_tags
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  application_load_balancer = module.alb.alb_dns_name
  iam_instance_profile_name = module.ssm_ec2.iam_ec2_instance_profile_name
  alb_security_group_id = module.security_group.security_group_id
  alb_target_group_arn = module.alb.alb_target_group_arn
  rds_db_endpoint = module.rds.rds_db_endpoint
}
