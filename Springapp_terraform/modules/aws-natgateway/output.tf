output "nat_gateway_1_id" {
    value = aws_nat_gateway.nat_gw_1.id
}

output "nat_gateway_2_id" {
    value = aws_nat_gateway.nat_gw_2.id
}   

output "private_route_table_1_id" {
    value = aws_route_table.private_rt_1.id
}

output "private_route_table_2_id" {
    value = aws_route_table.private_rt_2.id
}

output "eip_1_id" {
    value = aws_eip.nat_eip_1.id
}

output "eip_2_id" {
    value = aws_eip.nat_eip_2.id
}

output "project_name" {
    value = var.applicationName
}

output "environment" {
    value = var.environment
}