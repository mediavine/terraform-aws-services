locals {
  merge_containers = merge(var.container_definitions, var.sidecar_definitions)
}

resource "aws_ecs_task_definition" "this" {
  #required
  family                = var.task_definition_name
  container_definitions = jsonencode(values(local.merge_containers))

  #optional task attributes
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.execution_role_arn
  network_mode             = var.network_mode
  ipc_mode                 = var.requires_compatibilities == ["FARGATE"] ? "none" : null
  pid_mode                 = var.pid_mode
  requires_compatibilities = var.requires_compatibilities
  skip_destroy             = var.skip_destroy
  task_role_arn            = var.task_role_arn
  tags                     = var.tags

  ephemeral_storage {
    size_in_gib = var.size_in_gib
  }

  #required if using fargate; if requires_compatibilities is set to FARGATE, create required runtime platform
  dynamic "runtime_platform" {
    for_each = var.requires_compatibilities == ["FARGATE"] ? [1] : []
    content {
      operating_system_family = var.operating_system_family
      cpu_architecture        = var.cpu_architecture
    }
  }
  #create volume block if create_volume is true
  dynamic "volume" {
    for_each = var.create_volume ? [1] : []
    content {
      name      = var.volume_name
      host_path = var.host_path

      #optional; If scope is enabled, create the required docker volume
      dynamic "docker_volume_configuration" {
        for_each = var.scope == null ? [] : [1]
        content {
          scope         = var.scope
          autoprovision = var.autoprovision
          driver        = var.driver
          driver_opts   = var.driver_opts
          labels        = var.labels
        }
      }
      #optional; if file_system_id is enabled, create the required efs volume
      dynamic "efs_volume_configuration" {
        for_each = var.file_system_id != null ? [1] : []
        content {
          file_system_id          = var.file_system_id
          root_directory          = var.root_directory
          transit_encryption      = var.transit_encryption
          transit_encryption_port = var.transit_encryption_port
          authorization_config {
            access_point_id = var.access_point_id
            iam             = var.iam
          }
        }
      }
    }
  }
}
