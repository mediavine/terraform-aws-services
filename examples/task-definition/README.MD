# task-definition

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.MD updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_task_definition_example3"></a> [task\_definition\_example3](#module\_task\_definition\_example3) | ../../modules/task-definition/task-definition-module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources in. | `string` | `"us-east-1"` | no |
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_containerPort"></a> [containerPort](#input\_containerPort) | The port number on the container. | `number` | `3000` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container | `string` | `"sandbox5"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units used by the task. | `number` | `512` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | The ARN of the task execution role that grants the ECS agent permission to make AWS API calls on your behalf. | `string` | `"arn:aws:iam::023456789012:role/ecsTaskExecutionRole"` | no |
| <a name="input_fluentd_image"></a> [fluentd\_image](#input\_fluentd\_image) | The image uri used to start the sidecar container | `string` | `"fluentd/image"` | no |
| <a name="input_hostPort"></a> [hostPort](#input\_hostPort) | The port number on the container instance to reserve for your container. | `number` | `3000` | no |
| <a name="input_image"></a> [image](#input\_image) | The image uri used to start the container | `string` | `"nginx:latest"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory used by the task | `number` | `512` | no |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | The amount of memory used by the task | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the container | `string` | `"sandbox5"` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The network mode to use for the task. | `string` | `"awsvpc"` | no |
| <a name="input_pid_mode"></a> [pid\_mode](#input\_pid\_mode) | The process namespace to use for the containers in the task. | `string` | `"task"` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | The launch type the task definition was registered to. | `list(string)` | <pre>[<br/>  "FARGATE"<br/>]</pre> | no |
| <a name="input_sidecar_awslogs_group"></a> [sidecar\_awslogs\_group](#input\_sidecar\_awslogs\_group) | The log group to log to. | `string` | `"sidecar4-log-group"` | no |
| <a name="input_sidecar_awslogs_stream_prefix"></a> [sidecar\_awslogs\_stream\_prefix](#input\_sidecar\_awslogs\_stream\_prefix) | The prefix of the log stream. | `string` | `"firelens-sc"` | no |
| <a name="input_sidecar_name"></a> [sidecar\_name](#input\_sidecar\_name) | The name of the sidecar container | `string` | `"sidecar4"` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of cpu units defined at task level. Required when using Fargate. | `number` | `4096` | no |
| <a name="input_task_definition_name"></a> [task\_definition\_name](#input\_task\_definition\_name) | The name of the task definition. | `string` | `"sandbox5"` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory defined at task level. Required when using Fargate. | `number` | `8192` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->