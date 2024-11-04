locals {
  container_definition = {
    (var.container_name) = {
      name              = var.name
      command           = var.command
      cpu               = var.cpu
      essential         = var.essential
      image             = var.image
      memory            = var.memory
      memoryReservation = var.memory_reservation
      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.hostPort
          protocol      = var.protocol
        }
      ]
      logConfiguration = {
        logDriver = var.logDriver
        logOptions = {
          "awslogs-create-group"  = var.awslogs_create_group
          "awslogs-group"         = var.awslogs_group
          "awslogs-region"        = var.awslogs_region
          "awslogs-stream-prefix" = var.awslogs_stream_prefix
        }
      }
      environment    = []
      secrets        = []
      mountPoints    = [] #[]
      systemControls = [] #[]
      volumesFrom    = []
    }
  }

  sidecar_definition = {
    (var.sidecar_name) = {
      name                   = var.sidecar_name
      cpu                    = var.sidecar_cpu
      command                = var.sidecar_command
      memory                 = var.sidecar_memory
      memoryReservation      = var.sidecar_memory_reservation
      essential              = var.sidecar_essential
      user                   = var.sidecar_user #"0"
      image                  = var.fluentd_image
      environment            = []                                   #[]
      mountPoints            = []                                   #[]
      systemControls         = []                                   #[]
      volumesFrom            = []                                   #[]
      readonlyRootFilesystem = var.sidecar_readonly_root_filesystem #false
      portMappings = [
        {
          containerPort = var.sidecar_containerPort
          hostPort      = var.sidecar_hostPort
          protocol      = var.sidecar_protocol
        }
      ]
      logConfiguration = {
        logDriver = var.sidecar_logDriver
        options = {
          "awslogs-create-group"  = var.sidecar_awslogs_create_group
          "awslogs-group"         = var.sidecar_awslogs_group
          "awslogs-region"        = var.sidecar_awslogs_region
          "awslogs-stream-prefix" = var.sidecar_awslogs_stream_prefix
        }
      }
      firelensConfiguration = {
        type = var.sidecar_firelens_type
        options = {
          config-file-type  = var.sidecar_config_file_type
          config-file-value = var.sidecar_config_file_value
        }
      }

    }
  }
}
