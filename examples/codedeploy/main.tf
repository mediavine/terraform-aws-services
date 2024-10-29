module "codedeploy" {
  source = "../../modules/codedeploy"

  codedeploy_app_name            = "my-app"
  deployment_config_name         = "my-config"
  ecs_cluster_name               = "yadda" # referencing a sample app and not the actual dev environment
  ecs_service_name               = "yadda-yadda"
  load_balancer_arn              = "arn:aws:yadda-yadda"
  prod_lb_listener_arn           = ["arn:aws:yadda-yadda"]
  target_group_health_check_path = "/health"
  vpc_id                         = "vpc-yadda"
}
