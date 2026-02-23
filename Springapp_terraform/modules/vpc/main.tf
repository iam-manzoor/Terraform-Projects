# Create a VPC
resource "aws_vpc" "infrastructure_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  tags = merge(var.common_tags, {
    Name = "${var.applicationName}-infrastructure-vpc"
    Environment = var.environment
  })
}

# data source to fetch availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Create public subnets in different availability zones
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  cidr_block = var.public_subnet_1
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(var.common_tags, {
   Name = "${var.applicationName}-public-subnet-1"
   Environment = var.environment
  })
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.infrastructure_vpc.id
    cidr_block = var.public_subnet_2
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-public-subnet-2"
        Environment = var.environment
    })
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  tags = merge(var.common_tags, {
    Name = "${var.applicationName}-igw"
    Environment = var.environment
  })
}

# Create a route table and associate it with the public subnets
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.infrastructure_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-public-rt"
        Environment = var.environment
    })
}

# Associate the route tables with the public subnets
resource "aws_route_table_association" "public_rt_assoc_1" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc_2" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_rt.id
}

# Create the private subnets in different availability zones
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.infrastructure_vpc.id
    cidr_block = var.private_subnet_1
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-private-subnet-1"
        Environment = var.environment
    })
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.infrastructure_vpc.id
    cidr_block = var.private_subnet_2
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-private-subnet-2"
        Environment = var.environment
    })
}

# Create the Secure subnets in different availability zones
resource "aws_subnet" "secure_subnet_1" {
    vpc_id = aws_vpc.infrastructure_vpc.id
    cidr_block = var.secure_subnet_1
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-secure-subnet-1"
        Environment = var.environment
    })
}

resource "aws_subnet" "secure_subnet_2" {
    vpc_id = aws_vpc.infrastructure_vpc.id
    cidr_block = var.secure_subnet_2
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-secure-subnet-2"
        Environment = var.environment
    })
}