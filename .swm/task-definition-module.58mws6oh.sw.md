---
title: Task Definition Module
---
| Definitions for Containers                      | Available variables                                                                                                                      |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| container_definitions/sidecar_definitions&nbsp; | <SwmPath>[modules/task-definition/container-definition/README.MD](/modules/task-definition/container-definition/README.MD)</SwmPath>     |
| task definition                                 | <SwmPath>[modules/task-definition/task-definition-module/README.MD](/modules/task-definition/task-definition-module/README.MD)</SwmPath> |

## Container Definitions

To create the main container for the task definition, create an object called <SwmToken path="/modules/task-definition/container-definition/variables.tf" pos="205:3:3" line-data="variable &quot;container_definitions&quot; {">`container_definitions`</SwmToken>. Name, cpu, image, and memory are required parameters. All other values use a default but can be specified if needed.

Note: logConfiguration is using default values that should not be changed when deploying a fluentd container. Adjusting the default value could result in crashing the container.

<SwmSnippet path="/examples/task-definition/main.tf" line="13">

---

&nbsp;

```
  container_definitions = {
    (var.container_name) = {
      name               = var.name
      command            = var.command
      cpu                = var.cpu
      image              = var.image
      memory             = var.memory
      memory_reservation = var.memory_reservation
      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.hostPort
        }
      ]
    }
  }
  sidecar_definitions = {
    (var.sidecar_name) = {
      image        = var.fluentd_image
      logConfiguration = {
        options = {
          "awslogs-group"         = var.sidecar_awslogs_group
          "awslogs-stream-prefix" = var.sidecar_awslogs_stream_prefix
        }
      }
```

---

</SwmSnippet>

## Sidecar Definitions

Due to the main container having different default parameters, a separate container has to be created for the sidecar. To create the sidecar container, create an object called <SwmToken path="/modules/task-definition/container-definition/variables.tf" pos="255:3:3" line-data="variable &quot;sidecar_definitions&quot; {">`sidecar_definitions`</SwmToken>.&nbsp;&nbsp;

Name, memory, cpu, memory reservation, essential, user,  port mappings,  are using default values that can be adjusted if needed.

Note: Read only file system, and fire lens configuration are using default values that should not be adjusted when deploying a fluentd container. Adjusting the default value can the container to crash. For logConfiguration, adjusting <SwmToken path="/examples/task-definition/variables.tf" pos="125:3:3" line-data="variable &quot;sidecar_awslogs_group&quot; {">`sidecar_awslogs_group`</SwmToken> and <SwmToken path="/modules/task-definition/container-definition/variables.tf" pos="182:3:3" line-data="variable &quot;sidecar_awslogs_stream_prefix&quot; {">`sidecar_awslogs_stream_prefix`</SwmToken> is totally fine.

<SwmSnippet path="/examples/task-definition/main.tf" line="29">

---

&nbsp;

```tf
  sidecar_definitions = {
    (var.sidecar_name) = {
      image        = var.fluentd_image
      logConfiguration = {
        options = {
          "awslogs-group"         = var.sidecar_awslogs_group
          "awslogs-stream-prefix" = var.sidecar_awslogs_stream_prefix
        }
      }
    }
  }
}
```

---

</SwmSnippet>

## Task Definition

To create a task definition, you can choose from a list of additional parameters. Only task_definition_name and container_definitions (which contains sidecar_definitions) are required.&nbsp;&nbsp;

<SwmSnippet path="examples/task-definition/main.tf" line="1">

---

&nbsp;

```
module "task_definition_example3" {
  source                   = "../../modules/task-definition/task-definition-module"
  aws_region               = var.aws_region
  task_definition_name     = var.task_definition_name
  task_cpu                 = var.task_cpu
  task_memory              = var.task_memory
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  execution_role_arn       = var.execution_role_arn
  pid_mode                 = var.pid_mode


```

---

</SwmSnippet>

However, there are some parameters that when enabled, require other parameters. These parameters will created dynamically based on the values below:

|                                                                                                                                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| If requires_compatibilities is set to Fargate                                                                                                                                                                                                                                                                                                                                      | Set <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="21:3:3" line-data="variable &quot;ipc_mode&quot; {">`ipc_mode`</SwmToken> to "none"<br><br>runtime_platform will create dynamically and the following parameters can be used:<br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="70:3:3" line-data="variable &quot;operating_system_family&quot; {">`operating_system_family`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="76:3:3" line-data="variable &quot;cpu_architecture&quot; {">`cpu_architecture`</SwmToken>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| If <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="82:3:3" line-data="variable &quot;create_volume&quot; {">`create_volume`</SwmToken> is set to true                                                                                                                                                                                           | Create a volume and the following parameters can be used:<br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="88:3:3" line-data="variable &quot;volume_name&quot; {">`volume_name`</SwmToken>&nbsp;<br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="94:3:3" line-data="variable &quot;host_path&quot; {">`host_path`</SwmToken>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| If <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="82:3:3" line-data="variable &quot;create_volume&quot; {">`create_volume`</SwmToken> is set to true and <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="100:3:3" line-data="variable &quot;scope&quot; {">`scope`</SwmToken> is not null                   | docker_volume_configuration will be created dynamically and the following parameters can be used:<br><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="100:3:3" line-data="variable &quot;scope&quot; {">`scope`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="106:3:3" line-data="variable &quot;autoprovision&quot; {">`autoprovision`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="112:3:3" line-data="variable &quot;driver&quot; {">`driver`</SwmToken>&nbsp;<br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="118:3:3" line-data="variable &quot;driver_opts&quot; {">`driver_opts`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="124:3:3" line-data="variable &quot;labels&quot; {">`labels`</SwmToken>                                                                                                                                                                                                                                                                                                      |
| If <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="82:3:3" line-data="variable &quot;create_volume&quot; {">`create_volume`</SwmToken> is set to true and <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="130:3:3" line-data="variable &quot;file_system_id&quot; {">`file_system_id`</SwmToken> is not null | efs_volume_configuration will create dynamically and the following parameters can be used:<br><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="130:3:3" line-data="variable &quot;file_system_id&quot; {">`file_system_id`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="136:3:3" line-data="variable &quot;root_directory&quot; {">`root_directory`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="142:3:3" line-data="variable &quot;transit_encryption&quot; {">`transit_encryption`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="148:3:3" line-data="variable &quot;transit_encryption_port&quot; {">`transit_encryption_port`</SwmToken><br><br>Additional parameters included in authorization_config:<br><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="154:3:3" line-data="variable &quot;access_point_id&quot; {">`access_point_id`</SwmToken><br>- <SwmToken path="/modules/task-definition/task-definition-module/variables.tf" pos="160:3:3" line-data="variable &quot;iam&quot; {">`iam`</SwmToken> |

&nbsp;

## That's All Folks!

If you run into any issues or have suggestions for additional configuration, definitely let me know so I can add an issue and open a ticket.&nbsp;

<SwmMeta version="3.0.0" repo-id="Z2l0aHViJTNBJTNBdGVycmFmb3JtLWF3cy1zZXJ2aWNlcyUzQSUzQW1lZGlhdmluZQ==" repo-name="terraform-aws-services"><sup>Powered by [Swimm](https://app.swimm.io/)</sup></SwmMeta>
