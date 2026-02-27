# Module to create an Application Load Balancer (ALB) in AWS

resource "aws_lb" "alb" {
    name               = "${var.applicationName}-${var.environment}-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.alb_security_group_id]
    subnets           = [var.public_subnet_1_id, var.public_subnet_2_id]
    enable_deletion_protection = false

    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-${var.environment}-alb"
        Environment = var.environment
    })
}

# Create a target group for the ALB
resource "aws_lb_target_group" "alb_target_group" {
    name     = "${var.applicationName}-${var.environment}-alb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200-399"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 3
        unhealthy_threshold = 3
    }

    tags = merge(var.common_tags, {
        Name = "${var.applicationName}-${var.environment}-alb-tg"
        Environment = var.environment
    })

    lifecycle {
        create_before_destroy = true
    }
}

# Create a listener for the ALB tied to the target group
resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.alb_target_group.arn
    }
}

