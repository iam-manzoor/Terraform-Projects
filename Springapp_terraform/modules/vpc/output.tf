output "project_name" {
    value = var.applicationName
}

output "vpc_id" {
    value = aws_vpc.infrastructure_vpc.id
}

output "vpc_cidr_block" {
    value = aws_vpc.infrastructure_vpc.cidr_block
}

output "public_subnet_1_id" {
    value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
    value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
    value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
    value = aws_subnet.private_subnet_2.id
}

output "secure_subnet_1_id" {
    value = aws_subnet.secure_subnet_1.id
}

output "secure_subnet_2_id" {
    value = aws_subnet.secure_subnet_2.id
}

output "internet_gateway_id" {
    value = aws_internet_gateway.igw.id
}