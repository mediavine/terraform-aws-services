# codedeploy

## Use
Currently this module is written to add CodeDeploy to existing infrastructure code. It creates the CodeDeploy application and configuration and the resources such as listener and target group for the "test" or "green" resources. The changes needed to the existing infrastructure include updating the default action of the https listener to include forwarding rules that include both your existing target group and the one created by the CodeDeploy module.

```
forward {
        stickiness {
          duration = 3600
          enabled  = false
        }
        target_group {
          arn    = aws_lb_target_group.lb_https_tg.arn
        }
        target_group {
          arn    = module.codedeploy_modulename.test_target_group_arn
        }
      }

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.MD updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.47 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codedeploy_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_iam_policy.codedeploy_ecs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_code_deploy_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codedeploy_ecs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb_listener.lb_http_test_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.lb_http_test_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blue_instance_termination_success_time"></a> [blue\_instance\_termination\_success\_time](#input\_blue\_instance\_termination\_success\_time) | The number of minutes to wait before terminating the blue instances after a successful deployment | `number` | `5` | no |
| <a name="input_blue_lb_target_group_name"></a> [blue\_lb\_target\_group\_name](#input\_blue\_lb\_target\_group\_name) | The ARN of the blue load balancer target group | `string` | `""` | no |
| <a name="input_codedeploy_app_name"></a> [codedeploy\_app\_name](#input\_codedeploy\_app\_name) | The name of the CodeDeploy application | `string` | n/a | yes |
| <a name="input_compute_platform"></a> [compute\_platform](#input\_compute\_platform) | Acceptable values are ECS, Lambda, or Server | `string` | `"ECS"` | no |
| <a name="input_deployment_config_name"></a> [deployment\_config\_name](#input\_deployment\_config\_name) | The name of the deployment configuration. All available configurations are listed here: https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html | `string` | `"CodeDeployDefault.OneAtATime"` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount of time to wait before deregistering a target | `number` | `300` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | The name of the ECS cluster | `string` | `"default"` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | The name of the ECS service | `string` | `"default"` | no |
| <a name="input_green_lb_target_group_name"></a> [green\_lb\_target\_group\_name](#input\_green\_lb\_target\_group\_name) | The ARN of the green load balancer target group | `string` | `""` | no |
| <a name="input_green_target_group_port"></a> [green\_target\_group\_port](#input\_green\_target\_group\_port) | The port of the green target group | `number` | `3000` | no |
| <a name="input_http_test_listener_port"></a> [http\_test\_listener\_port](#input\_http\_test\_listener\_port) | The http (NOT https) port of the test traffic listener | `number` | `8080` | no |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | The ARN of the load balancer | `string` | n/a | yes |
| <a name="input_load_balancing_algorithm_type"></a> [load\_balancing\_algorithm\_type](#input\_load\_balancing\_algorithm\_type) | The load balancing algorithm to use | `string` | `"round_robin"` | no |
| <a name="input_prod_lb_listener_arn"></a> [prod\_lb\_listener\_arn](#input\_prod\_lb\_listener\_arn) | The ARN of the prod load balancer listener | `list(string)` | n/a | yes |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | The ARN of the IAM role to use for this deployment group | `string` | `""` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | The amount of time to wait before rerouting traffic to a new target | `number` | `60` | no |
| <a name="input_target_group_health_check_enabled"></a> [target\_group\_health\_check\_enabled](#input\_target\_group\_health\_check\_enabled) | Whether or not to enable health checks on the target group | `bool` | `true` | no |
| <a name="input_target_group_health_check_healthy_threshold"></a> [target\_group\_health\_check\_healthy\_threshold](#input\_target\_group\_health\_check\_healthy\_threshold) | The number of consecutive successful health checks required before considering the target healthy | `number` | `2` | no |
| <a name="input_target_group_health_check_interval"></a> [target\_group\_health\_check\_interval](#input\_target\_group\_health\_check\_interval) | The interval between health checks | `number` | `30` | no |
| <a name="input_target_group_health_check_matcher"></a> [target\_group\_health\_check\_matcher](#input\_target\_group\_health\_check\_matcher) | The HTTP response code to use for health checks | `string` | `"200"` | no |
| <a name="input_target_group_health_check_path"></a> [target\_group\_health\_check\_path](#input\_target\_group\_health\_check\_path) | The path to check for health | `string` | `"/"` | no |
| <a name="input_target_group_health_check_timeout"></a> [target\_group\_health\_check\_timeout](#input\_target\_group\_health\_check\_timeout) | The amount of time to wait for a health check response | `number` | `5` | no |
| <a name="input_target_group_health_check_unhealthy_threshold"></a> [target\_group\_health\_check\_unhealthy\_threshold](#input\_target\_group\_health\_check\_unhealthy\_threshold) | The number of consecutive failed health checks required before considering the target unhealthy | `number` | `2` | no |
| <a name="input_test_lb_listener_arn"></a> [test\_lb\_listener\_arn](#input\_test\_lb\_listener\_arn) | The ARN of the test load balancer listener | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codedeploy_app_arn"></a> [codedeploy\_app\_arn](#output\_codedeploy\_app\_arn) | ARN of the CodeDeploy application |
| <a name="output_codedeploy_app_name"></a> [codedeploy\_app\_name](#output\_codedeploy\_app\_name) | Name of the CodeDeploy application |
| <a name="output_codedeploy_application_id"></a> [codedeploy\_application\_id](#output\_codedeploy\_application\_id) | ID of the CodeDeploy application |
| <a name="output_codedeploy_id"></a> [codedeploy\_id](#output\_codedeploy\_id) | Amazon's assigned ID for the application |
| <a name="output_green_lb_target_group_name"></a> [green\_lb\_target\_group\_name](#output\_green\_lb\_target\_group\_name) | n/a |
| <a name="output_lb_http_test_tg_name"></a> [lb\_http\_test\_tg\_name](#output\_lb\_http\_test\_tg\_name) | n/a |
| <a name="output_test_listener_arn"></a> [test\_listener\_arn](#output\_test\_listener\_arn) | ARN of the test listener |
| <a name="output_test_target_group_name"></a> [test\_target\_group\_name](#output\_test\_target\_group\_name) | ARN of the test target group |
<!-- END_TF_DOCS -->
