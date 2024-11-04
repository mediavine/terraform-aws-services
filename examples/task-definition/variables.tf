##----------------------------------------------------------------##
## task definition vars
##-------------------------------------------------------------
variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "task_definition_name" {
  description = "The name of the task definition."
  type        = string
  default     = "sandbox5"
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
##  task definition vars required for fargate
##----------------------------------------------------------------##
variable "requires_compatibilities" {
  description = "The launch type the task definition was registered to."
  type        = list(string)
  default     = ["FARGATE"]
}

variable "execution_role_arn" {
  description = "The ARN of the task execution role that grants the ECS agent permission to make AWS API calls on your behalf."
  type        = string
  default     = "arn:aws:iam::023456789012:role/ecsTaskExecutionRole"
}

variable "pid_mode" {
  description = "The process namespace to use for the containers in the task."
  type        = string
  default     = "task"
}
##----------------------------------------------------------------##
## main container definition vars
##----------------------------------------------------------------##
variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "sandbox5"
}

variable "name" {
  description = "The name of the container"
  type        = string
  default     = "sandbox5"
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

variable "containerPort" {
  description = "The port number on the container."
  type        = number
  default     = 3000
}

variable "hostPort" {
  description = "The port number on the container instance to reserve for your container."
  type        = number
  default     = 3000
}

##----------------------------------------------------------------##
## sidecar container definition vars
##-------------------------------------------------------------
variable "sidecar_name" {
  description = "The name of the sidecar container"
  type        = string
  default     = "sidecar4"
}
variable "fluentd_image" {
  description = "The image uri used to start the sidecar container"
  type        = string
  default     = "fluentd/image"
}
variable "sidecar_awslogs_group" {
  description = "The log group to log to."
  type        = string
  default     = "sidecar4-log-group"
}

variable "sidecar_awslogs_stream_prefix" {
  description = "The prefix of the log stream."
  type        = string
  default     = "firelens-sc"
}
