variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}
##----------------------------------------------------------------##
##container definition vars
##----------------------------------------------------------------##
variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "name" {
  description = "The name of the container"
  type        = string
}

variable "command" {
  description = "The command that is passed to the container"
  type        = list(string)
  default     = []
}

variable "cpu" {
  description = "The number of cpu units used by the task. "
  type        = number
}

variable "essential" {
  description = "If the essential parameter of the container definition is marked as true"
  type        = bool
  default     = true
}

variable "image" {
  description = "The image uri used to start the container"
  type        = string
}

variable "memory" {
  description = "The amount of memory used by the task"
  type        = number
}

variable "memory_reservation" {
  description = "The amount of memory used by the task"
  type        = number
}

variable "containerPort" {
  description = "The port number on the container."
  type        = number
}

variable "hostPort" {
  description = "The port number on the container instance to reserve for your container."
  type        = number
}

variable "logDriver" {
  description = "The log driver to use for the container."
  type        = string
  default     = "awsfirelens"
}

variable "awslogs_create_group" {
  description = "If the log group should be created."
  type        = bool
  default     = null
}

variable "awslogs_group" {
  description = "The log group to log to."
  type        = string
  default     = null
}

variable "awslogs_region" {
  description = "The region of the log group."
  type        = string
  default     = null
}

variable "awslogs_stream_prefix" {
  description = "The prefix of the log stream."
  type        = string
  default     = null
}
variable "sidecar_name" {
  description = "The name of the sidecar container"
  type        = string
}

variable "sidecar_command" {
  description = "The command that is passed to the sidecar container"
  type        = list(string)
  default     = []
}

variable "sidecar_cpu" {
  description = "The number of cpu units used by the sidecar container"
  type        = number
}

variable "sidecar_memory" {
  description = "The amount of memory used by the sidecar container"
  type        = number
}

variable "sidecar_memory_reservation" {
  description = "The amount of memory used by the sidecar container"
  type        = number
}

variable "sidecar_essential" {
  description = "If the essential parameter of the sidecar container definition is marked as true"
  type        = bool
  default     = true
}

variable "sidecar_user" {
  description = "The user to run the sidecar container as"
  type        = string
  default     = "0"
}

variable "fluentd_image" {
  description = "The image uri used to start the sidecar container"
  type        = string
}
variable "sidecar_readonly_root_filesystem" {
  description = "If the sidecar container has a read only root filesystem"
  type        = bool
  default     = true
}

variable "sidecar_containerPort" {
  description = "The port number on the sidecar container."
  type        = number
}

variable "sidecar_hostPort" {
  description = "The port number on the container instance to reserve for your sidecar container."
  type        = number
}

variable "sidecar_protocol" {
  description = "The protocol used for the sidecar container."
  type        = string
  default     = "tcp"
}

variable "sidecar_logDriver" {
  description = "The log driver to use for the sidecar container."
  type        = string
  default     = "awslogs"
}

variable "sidecar_awslogs_create_group" {
  description = "If the log group should be created."
  type        = bool
  default     = true
}

variable "sidecar_awslogs_group" {
  description = "The log group to log to."
  type        = string
}

variable "sidecar_awslogs_region" {
  description = "The region of the log group."
  type        = string
  default     = "us-east-1"
}

variable "sidecar_awslogs_stream_prefix" {
  description = "The prefix of the log stream."
  type        = string
}

variable "sidecar_firelens_type" {
  description = "The type of firelens configuration to use."
  type        = string
  default     = "fluentd"
}

variable "sidecar_config_file_value" {
  description = "The value of the config file."
  type        = string
  default     = "/extra.conf"
}

variable "sidecar_config_file_type" {
  description = "The type of the config file."
  type        = string
  default     = "file"
}

variable "container_definitions" {
  description = "The container definitions to use for the task."
  type = map(object(
    {
    name               = string
    command            = optional(list(string))
    cpu                = number
    essential          = optional(bool, true)
    image              = string
    memory             = number
    memoryReservation  = optional(number)
    portMappings = list(object({
      containerPort = optional(number)
      hostPort      = optional(number)
      protocol      = optional(string, "tcp")
    }))
    logConfiguration = optional(object({
      logDriver = optional(string, "awsfirelens")
      options = optional(object({
        awslogs-create-group  = optional(string, null)
        awslogs-group         = optional(string, null)
        awslogs-region        = optional(string, null)
        awslogs-stream-prefix = optional(string, null)
      }))
    }))
    mountPoints = optional(list(object({
      containerPath = string
      sourceVolume  = string
      readOnly      = bool
    })))
    volumesFrom = optional(list(object({
      sourceContainer = string
      readOnly        = bool
    })))
    systemControls = optional(list(object({
      namespace = string
      value     = string
    })))
    readonlyRootFilesystem = optional(bool)
    environment = optional(list(object({
      name  = string
      value = string
    })))
    secrets = optional(list(object({
      name       = string
      value_from = string
    })))
}))
}

variable "sidecar_definitions" {
    description = "The sidecar definitions to use for the task."
    type        = map(object(
      {
        name                   = optional(string, "loki-fluentd")
        command                = optional(list(string))
        cpu                    = optional(number, 512)
        memory                 = optional(number, 512)
        memoryReservation     = optional(number, 512)
        essential              = optional(bool, true)
        user                   = optional(string, "0")
        image                  = optional(string, "")
        environment            = optional(list(object({
          name  = string
          value = string
        })))
        mountPoints            = optional(list(object({
          containerPath = string
          sourceVolume  = string
          readOnly      = bool
        })))
        systemControls          = optional(list(object({
          namespace = string
          value     = string
        })))
        volumesFrom             = optional(list(object({
          sourceContainer = string
          readOnly        = bool
        })))
        readonlyRootFilesystem = optional(bool, true)
        portMappings = optional(list(object({
          containerPort = optional(number, 2020)
          hostPort      = optional(number, 2020)
          protocol      = optional(string, "tcp")
        })))
        logConfiguration = optional(object({
          logDriver = optional(string, "awslogs")
          options = optional(object({
            awslogs-create-group  = optional(string, true)
            awslogs-group         = optional(string)
            awslogs-region        = optional(string, "us-east-1")
            awslogs-stream-prefix = optional(string)
          }))
        }))
        firelensConfiguration = optional(object({
          type = optional(string, "fluentd")
          options = optional(map(string), {
            config-file-type  = "file"
            config-file-value = "/extra.conf"
          })
        }))
      }
    ))
}