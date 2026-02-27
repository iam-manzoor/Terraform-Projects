output "vpc_endpoint_ids" {
  description = "The IDs of the VPC endpoints created for SSM, SSM Messages, and EC2 Messages."
  value       = { for key, endpoint in aws_vpc_endpoint.ssm_endpoints : key => endpoint.id }
}

output "iam_ec2_instance_profile_name" {
  description = "The name of the IAM instance profile for EC2 instances to access SSM."
  value       = aws_iam_instance_profile.ec2_ssm_instance_profile.name
}