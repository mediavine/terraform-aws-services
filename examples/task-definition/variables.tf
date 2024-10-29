variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "task_definition_name" {
  description = "The name of the task definition."
  type        = string
  default     = "sandbox3"
}

variable "task_cpu" {
  description = "The number of cpu units defined at task level. Required when using Fargate."
  type        = number
  default     = 4096
}

variable "task_memory" {
  description = "The amount of memory defined at task level. Required when using Fargate."
  type        = number
  default     = 8192
}

variable "network_mode" {
  description = "The network mode to use for the task."
  type        = string
  default     = "awsvpc"
}
##----------------------------------------------------------------##
##container definition vars
##----------------------------------------------------------------##
variable "container_name" {
    description = "The name of the container"
    type        = string
    default     = "sandbox3"
}

variable "name" {
    description = "The name of the container"
    type        = string
    default     = "sandbox3"
}

variable "command" {
    description = "The command that is passed to the container"
    type        = list(string)
    default     = []
}

variable "cpu" {
    description = "The number of cpu units used by the task. "
    type        = number
    default     = 512

}

variable "essential" {
    description = "If the essential parameter of the container definition is marked as true"
    type        = bool
    default     = true
}

variable "image" {
    description = "The image uri used to start the container"
    type        = string
    default     = "nginx:latest"
}

variable "memory" {
    description = "The amount of memory used by the task"
    type        = number
    default     = 512
}

variable "memory_reservation" {
    description = "The amount of memory used by the task"
    type        = number
    default     = 512
}

variable  "containerPort" {
    description = "The port number on the container."
    type        = number
    default     = 3000
}

variable "hostPort" {
    description = "The port number on the container instance to reserve for your container."
    type        = number
    default     = 3000
}

variable "logDriver" {
    description = "The log driver to use for the container."
    type        = string
    default     = "awsfirelens"
}

variable "awslogs_create_group" {
    description = "If the log group should be created."
    type        = bool
    default     = true
}

variable "awslogs_group" {
    description = "The log group to log to."
    type        = string
    default     = "example1-log"
}

variable "awslogs_region" {
    description = "The region of the log group."
    type        = string
    default     = "us-east-1"
}

variable "awslogs_stream_prefix" {
    description = "The prefix of the log stream."
    type        = string
    default     = "awslogs"
}

variable "sidecar_name" {
    description = "The name of the sidecar container"
    type        = string
    default     =   "sidecar1-container"
}

variable "sidecar_command" {
    description = "The command that is passed to the sidecar container"
    type        = list(string)
    default    = []
}

variable "sidecar_cpu" {
    description = "The number of cpu units used by the sidecar container"
    type        = number
    default     = 512
}

variable "sidecar_memory" {
    description = "The amount of memory used by the sidecar container"
    type        = number
    default     = 512
}

variable "sidecar_memory_reservation" {
    description = "The amount of memory used by the sidecar container"
    type        = number
    default     = 512
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
    default     = "fluentd/image"
}

variable "sidecar_readonly_root_filesystem" {
    description = "If the sidecar container has a read only root filesystem"
    type        = bool
    default     = false
}

variable "sidecar_containerPort" {
    description = "The port number on the sidecar container."
    type        = number
    default     = 2020
}

variable "sidecar_hostPort" {
    description = "The port number on the container instance to reserve for your sidecar container."
    type        = number
    default     = 2020
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
    default     = "sidecar2-log-group"
}

variable "sidecar_awslogs_region" {
    description = "The region of the log group."
    type        = string
    default     = "us-east-1"
}

variable "sidecar_awslogs_stream_prefix" {
    description = "The prefix of the log stream."
    type        = string
    default     = "firelens-sc"
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
