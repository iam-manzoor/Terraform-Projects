output "vpc" {
    value = module.vpc
}

output "nat_gateway" {
    value = module.natgateway
}

output "security_group" {
    value = module.security_group
}