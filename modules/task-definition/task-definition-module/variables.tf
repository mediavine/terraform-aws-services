variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}
##----------------------------------------------------------------##
## Optional vars
##----------------------------------------------------------------##
variable "execution_role_arn" {
  description = "The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  type        = string
  default     = ""
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "none"
}

variable "ipc_mode" {
  description = "The IPC resource namespace to use for the containers in the task."
  type        = string
  default     = "host"
}

variable "pid_mode" {
  description = "The process namespace to use for the containers in the task."
  type        = string
  default     = "host"
}

variable "requires_compatibilities" {
  description = "The launch type the task is compatible with. Valid values are EC2 and FARGATE."
  type        = set(string)
  default     = null
}

variable "skip_destroy" {
  description = "If the task should be skipped on destroy. Default is false"
  type        = bool
  default     = false
}

variable "task_role_arn" {
  description = "The Amazon Resource Name (ARN) of the task role that grants containers in the task permission to make calls to other aws services."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Key-value mapping of resource tags."
  type        = map(string)
  default     = {}
}

variable "track_latest" {
  description = "If the latest revision of the task definition should be tracked. Default is false"
  type        = bool
  default     = false
}

variable "size_in_gib" {
  description = "The size in GiB of the ephemeral storage to allocate for the task."
  type        = number
  default     = 21
}


variable "operating_system_family" {
  description = "The operating system family to use for the containers in the task."
  type        = string
  default     = "LINUX"
}

variable "cpu_architecture" {
  description = "The CPU architecture to use for the containers in the task."
  type        = string
  default     = ""
}

variable "create_volume" {
  description = "If true, a Docker volume is created and attached to the task."
  type        = bool
  default     = false
}

variable "volume_name" {
  description = "The name of the volume."
  type        = string
  default     = ""
}

variable "host_path" {
  description = "The path on the host container instance that is presented to the container. Not compatible with Fargate."
  type        = string
  default     = null
}

variable "scope" {
  description = "The scope for the Docker volume. The valid values are shared and task."
  type        = string
  default     = null
}

variable "autoprovision" {
  description = "If true, the Docker volume is created if it does not already exist. Should only be used if scope is shared."
  type        = bool
  default     = false
}

variable "driver" {
  description = "The Docker volume driver to use. Must match the driver name provided by Docker."
  type        = string
  default     = null
}

variable "driver_opts" {
  description = "A map of Docker driver options."
  type        = map(string)
  default     = null
}

variable "labels" {
  description = "A map of custom metadata to add to the Docker volume."
  type        = map(string)
  default     = null
}

variable "file_system_id" {
  description = "The ID of the Amazon EFS file system."
  type        = string
  default     = null
}

variable "root_directory" {
  description = "The root directory to mount to the host. Ignored when using authorization_config."
  type        = string
  default     = null
}

variable "transit_encryption" {
  description = "If true, the Amazon EFS file system is encrypted in transit Must be enabled if EFS IAM authorization is used."
  type        = bool
  default     = null
}

variable "transit_encryption_port" {
  description = "The port to use when encrypting traffic."
  type        = number
  default     = null
}

variable "access_point_id" {
  description = "The ID of the EFS access point."
  type        = string
  default     = null
}

variable "iam" {
  description = "If true, the Amazon ECS task IAM role is used for the EFS access point. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration"
  type        = bool
  default     = null
}

variable "task_definition_name" {
  description = "The name of the task definition."
  type        = string
}

variable "task_cpu" {
  description = "The number of cpu units defined at task level. Required when using Fargate.. "
  type        = number
}

variable "task_memory" {
  description = "The amount of memory defined at task level. Required when using Fargate."
  type        = number
}

##----------------------------------------------------------------##
##container definition vars
##----------------------------------------------------------------##

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
    memoryReservation = optional(number)
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
    description = "The sidevar definitions to use for the task."
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
            "config-file-type"  = "file"
            "config-file-value" = "/extra.conf"
          })
        }))
      }
    ))
}