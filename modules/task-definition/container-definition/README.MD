# container-definition

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.MD updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources in. | `string` | `"us-east-1"` | no |
| <a name="input_awslogs_create_group"></a> [awslogs\_create\_group](#input\_awslogs\_create\_group) | If the log group should be created. | `bool` | `null` | no |
| <a name="input_awslogs_group"></a> [awslogs\_group](#input\_awslogs\_group) | The log group to log to. | `string` | `null` | no |
| <a name="input_awslogs_region"></a> [awslogs\_region](#input\_awslogs\_region) | The region of the log group. | `string` | `null` | no |
| <a name="input_awslogs_stream_prefix"></a> [awslogs\_stream\_prefix](#input\_awslogs\_stream\_prefix) | The prefix of the log stream. | `string` | `null` | no |
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_containerPort"></a> [containerPort](#input\_containerPort) | The port number on the container. | `number` | n/a | yes |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | The container definitions to use for the task. | <pre>map(object(<br/>    {<br/>      name              = string<br/>      command           = optional(list(string))<br/>      cpu               = number<br/>      essential         = optional(bool, true)<br/>      image             = string<br/>      memory            = number<br/>      memoryReservation = optional(number)<br/>      portMappings = list(object({<br/>        containerPort = optional(number)<br/>        hostPort      = optional(number)<br/>        protocol      = optional(string, "tcp")<br/>      }))<br/>      logConfiguration = optional(object({<br/>        logDriver = optional(string, "awsfirelens")<br/>        options = optional(object({<br/>          awslogs-create-group  = optional(string, null)<br/>          awslogs-group         = optional(string, null)<br/>          awslogs-region        = optional(string, null)<br/>          awslogs-stream-prefix = optional(string, null)<br/>        }))<br/>      }), {})<br/>      mountPoints = optional(list(object({<br/>        containerPath = string<br/>        sourceVolume  = string<br/>        readOnly      = bool<br/>      })))<br/>      volumesFrom = optional(list(object({<br/>        sourceContainer = string<br/>        readOnly        = bool<br/>      })))<br/>      systemControls = optional(list(object({<br/>        namespace = string<br/>        value     = string<br/>      })))<br/>      readonlyRootFilesystem = optional(bool)<br/>      environment = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })))<br/>      secrets = optional(list(object({<br/>        name       = string<br/>        value_from = string<br/>      })))<br/>  }))</pre> | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units used by the task. | `number` | n/a | yes |
| <a name="input_essential"></a> [essential](#input\_essential) | If the essential parameter of the container definition is marked as true | `bool` | `true` | no |
| <a name="input_fluentd_image"></a> [fluentd\_image](#input\_fluentd\_image) | The image uri used to start the sidecar container | `string` | n/a | yes |
| <a name="input_hostPort"></a> [hostPort](#input\_hostPort) | The port number on the container instance to reserve for your container. | `number` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The image uri used to start the container | `string` | n/a | yes |
| <a name="input_logDriver"></a> [logDriver](#input\_logDriver) | The log driver to use for the container. | `string` | `"awsfirelens"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory used by the task | `number` | n/a | yes |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | The amount of memory used by the task | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the container | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol used for the container. | `string` | n/a | yes |
| <a name="input_sidecar_awslogs_create_group"></a> [sidecar\_awslogs\_create\_group](#input\_sidecar\_awslogs\_create\_group) | If the log group should be created. | `bool` | `true` | no |
| <a name="input_sidecar_awslogs_group"></a> [sidecar\_awslogs\_group](#input\_sidecar\_awslogs\_group) | The log group to log to. | `string` | n/a | yes |
| <a name="input_sidecar_awslogs_region"></a> [sidecar\_awslogs\_region](#input\_sidecar\_awslogs\_region) | The region of the log group. | `string` | `"us-east-1"` | no |
| <a name="input_sidecar_awslogs_stream_prefix"></a> [sidecar\_awslogs\_stream\_prefix](#input\_sidecar\_awslogs\_stream\_prefix) | The prefix of the log stream. | `string` | n/a | yes |
| <a name="input_sidecar_command"></a> [sidecar\_command](#input\_sidecar\_command) | The command that is passed to the sidecar container | `list(string)` | `[]` | no |
| <a name="input_sidecar_config_file_type"></a> [sidecar\_config\_file\_type](#input\_sidecar\_config\_file\_type) | The type of the config file. | `string` | `"file"` | no |
| <a name="input_sidecar_config_file_value"></a> [sidecar\_config\_file\_value](#input\_sidecar\_config\_file\_value) | The value of the config file. | `string` | `"/extra.conf"` | no |
| <a name="input_sidecar_containerPort"></a> [sidecar\_containerPort](#input\_sidecar\_containerPort) | The port number on the sidecar container. | `number` | n/a | yes |
| <a name="input_sidecar_cpu"></a> [sidecar\_cpu](#input\_sidecar\_cpu) | The number of cpu units used by the sidecar container | `number` | n/a | yes |
| <a name="input_sidecar_definitions"></a> [sidecar\_definitions](#input\_sidecar\_definitions) | The sidecar definitions to use for the task. | <pre>map(object(<br/>    {<br/>      name              = optional(string, "loki-fluentd")<br/>      command           = optional(list(string))<br/>      cpu               = optional(number, 512)<br/>      memory            = optional(number, 512)<br/>      memoryReservation = optional(number, 512)<br/>      essential         = optional(bool, true)<br/>      user              = optional(string, "0")<br/>      image             = optional(string, "")<br/>      environment = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })))<br/>      mountPoints = optional(list(object({<br/>        containerPath = string<br/>        sourceVolume  = string<br/>        readOnly      = bool<br/>      })))<br/>      systemControls = optional(list(object({<br/>        namespace = string<br/>        value     = string<br/>      })))<br/>      volumesFrom = optional(list(object({<br/>        sourceContainer = string<br/>        readOnly        = bool<br/>      })))<br/>      readonlyRootFilesystem = optional(bool, true)<br/>      portMappings = optional(list(object({<br/>        containerPort = optional(number, 2020)<br/>        hostPort      = optional(number, 2020)<br/>        protocol      = optional(string, "tcp")<br/>      })), [{}])<br/>      logConfiguration = optional(object({<br/>        logDriver = optional(string, "awslogs")<br/>        options = optional(object({<br/>          awslogs-create-group  = optional(string, true)<br/>          awslogs-group         = optional(string)<br/>          awslogs-region        = optional(string, "us-east-1")<br/>          awslogs-stream-prefix = optional(string)<br/>        }))<br/>      }))<br/>      firelensConfiguration = optional(object({<br/>        type = optional(string, "fluentd")<br/>        options = optional(map(string), {<br/>          "config-file-type"  = "file"<br/>          "config-file-value" = "/extra.conf"<br/>        })<br/>      }), {})<br/>    }<br/>  ))</pre> | n/a | yes |
| <a name="input_sidecar_essential"></a> [sidecar\_essential](#input\_sidecar\_essential) | If the essential parameter of the sidecar container definition is marked as true | `bool` | `true` | no |
| <a name="input_sidecar_firelens_type"></a> [sidecar\_firelens\_type](#input\_sidecar\_firelens\_type) | The type of firelens configuration to use. | `string` | `"fluentd"` | no |
| <a name="input_sidecar_hostPort"></a> [sidecar\_hostPort](#input\_sidecar\_hostPort) | The port number on the container instance to reserve for your sidecar container. | `number` | n/a | yes |
| <a name="input_sidecar_logDriver"></a> [sidecar\_logDriver](#input\_sidecar\_logDriver) | The log driver to use for the sidecar container. | `string` | `"awslogs"` | no |
| <a name="input_sidecar_memory"></a> [sidecar\_memory](#input\_sidecar\_memory) | The amount of memory used by the sidecar container | `number` | n/a | yes |
| <a name="input_sidecar_memory_reservation"></a> [sidecar\_memory\_reservation](#input\_sidecar\_memory\_reservation) | The amount of memory used by the sidecar container | `number` | n/a | yes |
| <a name="input_sidecar_name"></a> [sidecar\_name](#input\_sidecar\_name) | The name of the sidecar container | `string` | n/a | yes |
| <a name="input_sidecar_protocol"></a> [sidecar\_protocol](#input\_sidecar\_protocol) | The protocol used for the sidecar container. | `string` | `"tcp"` | no |
| <a name="input_sidecar_readonly_root_filesystem"></a> [sidecar\_readonly\_root\_filesystem](#input\_sidecar\_readonly\_root\_filesystem) | If the sidecar container has a read only root filesystem | `bool` | `true` | no |
| <a name="input_sidecar_user"></a> [sidecar\_user](#input\_sidecar\_user) | The user to run the sidecar container as | `string` | `"0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_definitions"></a> [container\_definitions](#output\_container\_definitions) | container definition to pass to ecs service |
| <a name="output_sidecar_definitions"></a> [sidecar\_definitions](#output\_sidecar\_definitions) | sidecar definition to pass to ecs service |
<!-- END_TF_DOCS -->
