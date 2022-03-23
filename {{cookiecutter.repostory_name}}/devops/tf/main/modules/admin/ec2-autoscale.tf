locals {
  name_env = var.env == "prod" ? var.name : "${var.name}-${var.env}"
}

resource "aws_launch_template" "admin" {
  name          = local.name_env
  image_id      = var.base_ami_id
  instance_type = "t3.medium"

  iam_instance_profile {
    name = aws_iam_instance_profile.admin.name
  }

  disable_api_termination = false
  key_name                = aws_key_pair.rsa.key_name

  user_data = base64encode(file("../../config/admin.yaml"))

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      encrypted = true
      volume_size = 20
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  vpc_security_group_ids = [
    aws_security_group.internal.id
  ]
}

resource "aws_autoscaling_group" "admin" {
  name                = local.name_env
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [var.subnets[0]]

  launch_template {
    id = aws_launch_template.admin.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    propagate_at_launch = true
    value = var.name
  }

  target_group_arns = [
    aws_lb_target_group.admin.arn
  ]
}
