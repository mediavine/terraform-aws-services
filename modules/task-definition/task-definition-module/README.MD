# task-definition-module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.MD updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_point_id"></a> [access\_point\_id](#input\_access\_point\_id) | The ID of the EFS access point. | `string` | `null` | no |
| <a name="input_autoprovision"></a> [autoprovision](#input\_autoprovision) | If true, the Docker volume is created if it does not already exist. Should only be used if scope is shared. | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources in. | `string` | `"us-east-1"` | no |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | The container definitions to use for the task. | <pre>map(object(<br>    {<br>      name              = string<br>      command           = optional(list(string))<br>      cpu               = number<br>      essential         = optional(bool, true)<br>      image             = string<br>      memory            = number<br>      memoryReservation = optional(number)<br>      portMappings = list(object({<br>        containerPort = optional(number)<br>        hostPort      = optional(number)<br>        protocol      = optional(string, "tcp")<br>      }))<br>      logConfiguration = optional(object({<br>        logDriver = optional(string, "awsfirelens")<br>        options = optional(object({<br>          awslogs-create-group  = optional(string, null)<br>          awslogs-group         = optional(string, null)<br>          awslogs-region        = optional(string, null)<br>          awslogs-stream-prefix = optional(string, null)<br>        }))<br>      }))<br>      mountPoints = optional(list(object({<br>        containerPath = string<br>        sourceVolume  = string<br>        readOnly      = bool<br>      })))<br>      volumesFrom = optional(list(object({<br>        sourceContainer = string<br>        readOnly        = bool<br>      })))<br>      systemControls = optional(list(object({<br>        namespace = string<br>        value     = string<br>      })))<br>      readonlyRootFilesystem = optional(bool)<br>      environment = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>      secrets = optional(list(object({<br>        name       = string<br>        value_from = string<br>      })))<br>  }))</pre> | n/a | yes |
| <a name="input_cpu_architecture"></a> [cpu\_architecture](#input\_cpu\_architecture) | The CPU architecture to use for the containers in the task. | `string` | `""` | no |
| <a name="input_create_volume"></a> [create\_volume](#input\_create\_volume) | If true, a Docker volume is created and attached to the task. | `bool` | `false` | no |
| <a name="input_driver"></a> [driver](#input\_driver) | The Docker volume driver to use. Must match the driver name provided by Docker. | `string` | `null` | no |
| <a name="input_driver_opts"></a> [driver\_opts](#input\_driver\_opts) | A map of Docker driver options. | `map(string)` | `null` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. | `string` | `""` | no |
| <a name="input_file_system_id"></a> [file\_system\_id](#input\_file\_system\_id) | The ID of the Amazon EFS file system. | `string` | `null` | no |
| <a name="input_host_path"></a> [host\_path](#input\_host\_path) | The path on the host container instance that is presented to the container. Not compatible with Fargate. | `string` | `null` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | If true, the Amazon ECS task IAM role is used for the EFS access point. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration | `bool` | `null` | no |
| <a name="input_ipc_mode"></a> [ipc\_mode](#input\_ipc\_mode) | The IPC resource namespace to use for the containers in the task. | `string` | `"host"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of custom metadata to add to the Docker volume. | `map(string)` | `null` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host. | `string` | `"none"` | no |
| <a name="input_operating_system_family"></a> [operating\_system\_family](#input\_operating\_system\_family) | The operating system family to use for the containers in the task. | `string` | `"LINUX"` | no |
| <a name="input_pid_mode"></a> [pid\_mode](#input\_pid\_mode) | The process namespace to use for the containers in the task. | `string` | `"host"` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | The launch type the task is compatible with. Valid values are EC2 and FARGATE. | `set(string)` | `null` | no |
| <a name="input_root_directory"></a> [root\_directory](#input\_root\_directory) | The root directory to mount to the host. Ignored when using authorization\_config. | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope for the Docker volume. The valid values are shared and task. | `string` | `null` | no |
| <a name="input_sidecar_definitions"></a> [sidecar\_definitions](#input\_sidecar\_definitions) | The sidecar definitions to use for the task. | <pre>map(object(<br>    {<br>      name              = optional(string, "loki-fluentd")<br>      command           = optional(list(string))<br>      cpu               = optional(number, 512)<br>      memory            = optional(number, 512)<br>      memoryReservation = optional(number, 512)<br>      essential         = optional(bool, true)<br>      user              = optional(string, "0")<br>      image             = optional(string, "")<br>      environment = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>      mountPoints = optional(list(object({<br>        containerPath = string<br>        sourceVolume  = string<br>        readOnly      = bool<br>      })))<br>      systemControls = optional(list(object({<br>        namespace = string<br>        value     = string<br>      })))<br>      volumesFrom = optional(list(object({<br>        sourceContainer = string<br>        readOnly        = bool<br>      })))<br>      readonlyRootFilesystem = optional(bool, true)<br>      portMappings = optional(list(object({<br>        containerPort = optional(number, 2020)<br>        hostPort      = optional(number, 2020)<br>        protocol      = optional(string, "tcp")<br>      })))<br>      logConfiguration = optional(object({<br>        logDriver = optional(string, "awslogs")<br>        options = optional(object({<br>          awslogs-create-group  = optional(string, true)<br>          awslogs-group         = optional(string)<br>          awslogs-region        = optional(string, "us-east-1")<br>          awslogs-stream-prefix = optional(string)<br>        }))<br>      }))<br>      firelensConfiguration = optional(object({<br>        type = optional(string, "fluentd")<br>        options = optional(map(string), {<br>          "config-file-type"  = "file"<br>          "config-file-value" = "/extra.conf"<br>        })<br>      }))<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_size_in_gib"></a> [size\_in\_gib](#input\_size\_in\_gib) | The size in GiB of the ephemeral storage to allocate for the task. | `number` | `21` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | If the task should be skipped on destroy. Default is false | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value mapping of resource tags. | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of cpu units defined at task level. Required when using Fargate.. | `number` | n/a | yes |
| <a name="input_task_definition_name"></a> [task\_definition\_name](#input\_task\_definition\_name) | The name of the task definition. | `string` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory defined at task level. Required when using Fargate. | `number` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The Amazon Resource Name (ARN) of the task role that grants containers in the task permission to make calls to other aws services. | `string` | `""` | no |
| <a name="input_track_latest"></a> [track\_latest](#input\_track\_latest) | If the latest revision of the task definition should be tracked. Default is false | `bool` | `false` | no |
| <a name="input_transit_encryption"></a> [transit\_encryption](#input\_transit\_encryption) | If true, the Amazon EFS file system is encrypted in transit Must be enabled if EFS IAM authorization is used. | `bool` | `null` | no |
| <a name="input_transit_encryption_port"></a> [transit\_encryption\_port](#input\_transit\_encryption\_port) | The port to use when encrypting traffic. | `number` | `null` | no |
| <a name="input_volume_name"></a> [volume\_name](#input\_volume\_name) | The name of the volume. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_with_revision"></a> [arn\_with\_revision](#output\_arn\_with\_revision) | ARN of the Task Definition with the trailing revision removed. |
| <a name="output_arn_without_revision"></a> [arn\_without\_revision](#output\_arn\_without\_revision) | Revision of the task in a particular family |
| <a name="output_task_arn"></a> [task\_arn](#output\_task\_arn) | n/a |
<!-- END_TF_DOCS -->
