# Create Elastic IP for NAT Gateway Per AZ1
resource "aws_eip" "nat_eip_1" {
    domain = "vpc"
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-nat-eip-1"
        Environment = var.environment
    })
}

# Create Elastic IP for NAT Gateway Per AZ2
resource "aws_eip" "nat_eip_2" {
    domain = "vpc"
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-nat-eip-2"
        Environment = var.environment
    })
}
/*
We can use single subnet for NAT Gateway, but for high availability we are creating 
two NAT Gateways in two different AZs and associate them with private route tables 
accordingly. This way if one AZ goes down, the other NAT Gateway will still be 
available to provide internet access to the private subnets.
*/
# Create the NAT Gateway in the public subnet1
resource "aws_nat_gateway" "nat_gw_1" {
    allocation_id = aws_eip.nat_eip_1.id
    subnet_id = var.public_subnet_1_id
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-nat-gw-1"
        Environment = var.environment
    })

    depends_on = [var.internet_gateway_id]
}

# Create the NAT Gateway in the public subnet2
resource "aws_nat_gateway" "nat_gw_2" {
    allocation_id = aws_eip.nat_eip_2.id
    subnet_id = var.public_subnet_2_id
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-nat-gw-2"
        Environment = var.environment
    })

    depends_on = [var.internet_gateway_id]
}

resource "aws_route_table" "private_rt_1" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_1.id
    }

    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-private-rt-1"
        Environment = var.environment
    })
}

resource "aws_route_table_association" "private_rt_assoc_1" {
    subnet_id = var.private_subnet_1_id
    route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table" "private_rt_2" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_2.id
    }

    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-private-rt-2"
        Environment = var.environment
    })
}

resource "aws_route_table_association" "private_rt_assoc_2" {
    subnet_id = var.private_subnet_2_id
    route_table_id = aws_route_table.private_rt_2.id
}
