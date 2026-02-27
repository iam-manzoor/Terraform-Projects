output "alb_id" {
    description = "The ID of the Application Load Balancer (ALB) created."
    value       = aws_lb.alb.id
}

output "alb_dns_name" {
    description = "The DNS name of the Application Load Balancer (ALB)."
    value       = aws_lb.alb.dns_name
}

output "alb_target_group_arn" {
    description = "The ARN of the ALB target group."
    value       = aws_lb_target_group.alb_target_group.arn
}

output "alb" {
    description = "The details of the Application Load Balancer (ALB) created."
    value       = aws_lb.alb
}
