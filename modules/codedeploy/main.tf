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
        listener_arns = var.test_lb_listener_arns
      }

      target_group {
        name = var.blue_lb_target_group_arn
      }

      target_group {
        name = var.green_lb_target_group_arn
      }

    }
  }
}
