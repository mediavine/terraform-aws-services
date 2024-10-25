# codedeploy

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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blue_instance_termination_success_time"></a> [blue\_instance\_termination\_success\_time](#input\_blue\_instance\_termination\_success\_time) | The number of minutes to wait before terminating the blue instances after a successful deployment | `number` | `5` | no |
| <a name="input_blue_lb_target_group_arn"></a> [blue\_lb\_target\_group\_arn](#input\_blue\_lb\_target\_group\_arn) | The ARN of the blue load balancer target group | `string` | n/a | yes |
| <a name="input_codedeploy_app_name"></a> [codedeploy\_app\_name](#input\_codedeploy\_app\_name) | The name of the CodeDeploy application | `string` | n/a | yes |
| <a name="input_compute_platform"></a> [compute\_platform](#input\_compute\_platform) | Acceptable values are ECS, Lambda, or Server | `string` | `"ECS"` | no |
| <a name="input_deployment_config_name"></a> [deployment\_config\_name](#input\_deployment\_config\_name) | The name of the deployment configuration. All available configurations are listed here: https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html | `string` | `"CodeDeployDefault.OneAtATime"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | The name of the ECS cluster | `string` | `"default"` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | The name of the ECS service | `string` | `"default"` | no |
| <a name="input_green_lb_target_group_arn"></a> [green\_lb\_target\_group\_arn](#input\_green\_lb\_target\_group\_arn) | The ARN of the green load balancer target group | `string` | n/a | yes |
| <a name="input_prod_lb_listener_arns"></a> [prod\_lb\_listener\_arns](#input\_prod\_lb\_listener\_arns) | The ARNs of the prod load balancer listener | `list(string)` | n/a | yes |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | The ARN of the IAM role to use for this deployment group | `string` | n/a | yes |
| <a name="input_test_lb_listener_arns"></a> [test\_lb\_listener\_arns](#input\_test\_lb\_listener\_arns) | The ARNs of the test load balancer listener | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codedeploy_app_arn"></a> [codedeploy\_app\_arn](#output\_codedeploy\_app\_arn) | ARN of the CodeDeploy application |
| <a name="output_codedeploy_app_name"></a> [codedeploy\_app\_name](#output\_codedeploy\_app\_name) | Name of the CodeDeploy application |
| <a name="output_codedeploy_application_id"></a> [codedeploy\_application\_id](#output\_codedeploy\_application\_id) | ID of the CodeDeploy application |
| <a name="output_codedeploy_id"></a> [codedeploy\_id](#output\_codedeploy\_id) | Amazon's assigned ID for the application |
<!-- END_TF_DOCS -->
