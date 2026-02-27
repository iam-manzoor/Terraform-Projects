# Creating SG for the vpc endpoint
resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "${var.applicationName}-${var.environment}-ssm-endpoint-sg"
  description = "Security group for SSM VPC Endpoint"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" : "${var.applicationName}-${var.environment}-ssm-endpoint-sg"
    }
  )
}

# Defining the VPC Endpoint for SSM
locals {
  endpoints = {
    "endpoint-ssm" = {
        name = "ssm"
    }
    "endpoint-ssmmessages" = {
        name = "ssmmessages"
    }
    "endpoint-ec2messages" = {
        name = "ec2messages"
    }
  } 
}

# Creating VPC Endpoints for SSM, SSM Messages, and EC2 Messages
resource "aws_vpc_endpoint" "ssm_endpoints" {
    for_each       = local.endpoints
    vpc_id         = var.vpc_id
    service_name   = "com.amazonaws.${var.region}.${each.value.name}"
    vpc_endpoint_type = "Interface"
    security_group_ids = [aws_security_group.vpc_endpoint_sg.id]
    
    tags = merge(
        var.common_tags,
        {
        "Name" : "${var.applicationName}-${var.environment}-${each.value.name}-endpoint"
        }
    )
}

# Creating an IAM role for EC2 instances to access SSM
resource "aws_iam_role" "ec2_ssm_role" {
  name = "${var.applicationName}-${var.environment}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      "Name" : "${var.applicationName}-${var.environment}-ec2-ssm-role"
    }
  )
}

# Attaching the AmazonSSMManagedInstanceCore policy to the IAM role
resource "aws_iam_role_policy_attachment" "ec2_ssm_role_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Profile for EC2 instances to use the IAM role
resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "${var.applicationName}-${var.environment}-ec2-ssm-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name

  tags = merge(
    var.common_tags,
    {
      "Name" : "${var.applicationName}-${var.environment}-ec2-ssm-instance-profile"
    }
  )
}
