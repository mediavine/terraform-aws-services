module "task_definition_example3" {
  source               = "../../modules/task-definition/task-definition-module"
  aws_region           = var.aws_region
  task_definition_name = var.task_definition_name
  task_cpu             = var.task_cpu
  task_memory          = var.task_memory
  network_mode         = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  execution_role_arn = var.execution_role_arn
  pid_mode = var.pid_mode


  container_definitions = {
    (var.container_name) = {
      name      = var.name
      command   = var.command
      cpu       = var.cpu
      image     = var.image
      memory    = var.memory
      memory_reservation   = var.memory_reservation
      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.hostPort
        }
      ]
      logConfiguration = {}
    }
  }
    sidecar_definitions = {
    (var.sidecar_name) = {
      image                  = var.fluentd_image
      portMappings = [{}]
      logConfiguration = {
        options = {
          "awslogs-group"         = var.sidecar_awslogs_group
          "awslogs-stream-prefix" = var.sidecar_awslogs_stream_prefix
        }
      }
      firelensConfiguration = {}
    }
  }
}