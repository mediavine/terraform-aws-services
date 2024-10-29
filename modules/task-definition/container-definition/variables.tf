variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
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
}

variable "cpu" {
  description = "The number of cpu units used by the task. "
  type        = number
}

variable "essential" {
  description = "If the essential parameter of the container definition is marked as true"
  type        = bool
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
}

variable "awslogs_create_group" {
  description = "If the log group should be created."
  type        = bool
}

variable "awslogs_group" {
  description = "The log group to log to."
  type        = string
}

variable "awslogs_region" {
  description = "The region of the log group."
  type        = string
}

variable "awslogs_stream_prefix" {
  description = "The prefix of the log stream."
  type        = string
}
variable "sidecar_name" {
  description = "The name of the sidecar container"
  type        = string
}

variable "sidecar_command" {
  description = "The command that is passed to the sidecar container"
  type        = list(string)
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
}

variable "sidecar_user" {
  description = "The user to run the sidecar container as"
  type        = string
}

variable "fluentd_image" {
  description = "The image uri used to start the sidecar container"
  type        = string
}
variable "sidecar_readonly_root_filesystem" {
  description = "If the sidecar container has a read only root filesystem"
  type        = bool
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
}

variable "sidecar_logDriver" {
  description = "The log driver to use for the sidecar container."
  type        = string
}

variable "sidecar_awslogs_create_group" {
  description = "If the log group should be created."
  type        = bool
}

variable "sidecar_awslogs_group" {
  description = "The log group to log to."
  type        = string
}

variable "sidecar_awslogs_region" {
  description = "The region of the log group."
  type        = string
}

variable "sidecar_awslogs_stream_prefix" {
  description = "The prefix of the log stream."
  type        = string
}

variable "sidecar_firelens_type" {
  description = "The type of firelens configuration to use."
  type        = string
}

variable "sidecar_config_file_value" {
  description = "The value of the config file."
  type        = string
  default     = "/extra.conf"
}

variable "sidecar_config_file_type" {
  description = "The type of the config file."
  type        = string
}

variable "container_definitions" {
  description = "The container definitions to use for the task."
  type = map(object({
    name               = string
    command            = optional(list(string))
    cpu                = number
    essential          = bool
    image              = string
    memory             = number
    memory_reservation = optional(number)
    portMapping = list(object({
      containerPort = number
      hostPort      = number
      protocol      = optional(string)
    }))
    firelensConfiguration = optional(object({
      type = string
      options = optional(map(object({
        config-file-type  = string
        config-file-value = string
      })))
    }))
    logConfiguration = optional(object({
      logDriver = string
      options = object({
        awslogs-create-group  = string
        awslogs-group         = string
        awslogs-region        = string
        awslogs-stream-prefix = string
      })
    }))
    user = optional(string)
    mountPoints = optional(list(object({
      containerPath = string
      sourceVolume  = string
      readOnly      = bool
    })))
    volumeFrom = optional(list(object({
      sourceContainer = string
      readOnly        = bool
    })))
    systemControl = optional(list(object({
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