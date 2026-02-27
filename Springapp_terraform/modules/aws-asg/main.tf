data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Create a ASG launch template
resource "aws_launch_template" "asg_launch_template" {
  name   = "${var.applicationName}-${var.environment}-asg-launch-template-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"
  security_group_names = [var.alb_security_group_id]
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
  user_data = base64encode(templatefile(("userdata.sh"), {mysql_url = var.rds_db_endpoint}))

  tags = merge(var.common_tags, {
    Name        = "${var.applicationName}-${var.environment}-asg-instance"
    Environment = var.environment
  })
  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group (ASG) with the launch template
resource "aws_autoscaling_group" "asg" {
    name                      = "${var.applicationName}-${var.environment}-asg"
    max_size                  = 1
    min_size                  = 1
    desired_capacity          = 1
    force_delete               = true
    depends_on = [var.application_load_balancer]
    target_group_arns         = [var.alb_target_group_arn]
    launch_template {
        id      = aws_launch_template.asg_launch_template.id
        version = aws_launch_template.asg_launch_template.latest_version
    }
    vpc_zone_identifier       = [var.private_subnet_1_id, var.private_subnet_2_id]
    health_check_type         = "ELB"
    health_check_grace_period = 300
    
    tag {
    key                 = "Name"
    value               = "${var.applicationName}-${var.environment}-ASG"
    propagate_at_launch = true
  }
    
    lifecycle {
        create_before_destroy = true
    }
}