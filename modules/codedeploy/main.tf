resource "aws_codedeploy_app" "this" {
  compute_platform = var.compute_platform
  name             = var.codedeploy_app_name
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = aws_codedeploy_app.this.name
  deployment_group_name  = "${var.codedeploy_app_name}-group-name"
  deployment_config_name = var.deployment_config_name
  service_role_arn       = var.service_role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = var.blue_instance_termination_success_time
    }
  }


  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  } #TODO: Add support for Lambda and Server deployments

  load_balancer_info {
    target_group_pair_info {

      prod_traffic_route {
        listener_arns = var.prod_lb_listener_arns
      }

      test_traffic_route {
        listener_arns = length(var.test_lb_listener_arns) <= 1 ? aws_lb_listener.lb_http_test_listener[0].arn : var.test_lb_listener_arns
      }

      target_group {
        name = var.blue_lb_target_group_arn
      }

      target_group {
        name = length(var.green_lb_target_group_arn) <= 1 ? aws_lb_target_group.lb_http_test_tg[0].arn : var.green_lb_target_group_arn
      }

    }
  }
}

resource "aws_lb_listener" "lb_http_test_listener" {
  count = length(var.test_lb_listener_arns) <= 1 ? 1 : 0

  load_balancer_arn = var.load_balancer_arn
  port              = var.http_test_listener_port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.lb_http_test_tg[0].arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "lb_http_test_tg" {
  count = length(var.green_lb_target_group_arn) <= 1 ? 1 : 0

  name                          = "green-${var.ecs_service_name}"
  port                          = var.green_target_group_port
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  slow_start                    = var.slow_start
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  stickiness {
    type            = "lb_cookie"
    enabled         = false #this has historically caused issues with our type of services so the is hardcoded to false
    cookie_duration = 86400
  }
  health_check {
    enabled             = var.target_group_health_check_enabled
    interval            = var.target_group_health_check_interval
    path                = var.target_group_health_check_path
    protocol            = "HTTP"
    timeout             = var.target_group_health_check_timeout
    healthy_threshold   = var.target_group_health_check_healthy_threshold
    unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
    matcher             = var.target_group_health_check_matcher
  }
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }
}
