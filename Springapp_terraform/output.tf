output "vpc" {
    value = module.vpc
}

output "nat_gateway" {
    value = module.natgateway
}

output "security_group" {
    value = module.security_group
}

output "ssm_ec2" {
    value = module.ssm_ec2
}

output "alb" {
    value = module.alb
}

output "rds" {
    value = module.rds
}

output "asg" {
    value = module.asg
}