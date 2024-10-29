### AWS CodeDeploy Application INPUTS ###
variable "compute_platform" {
  type        = string
  default     = "ECS"
  description = "Acceptable values are ECS, Lambda, or Server"
}

variable "codedeploy_app_name" {
  type        = string
  description = "The name of the CodeDeploy application"
}

### AWS CodeDeploy Deployment Group INPUTS ###
variable "deployment_config_name" {
  type        = string
  default     = "CodeDeployDefault.OneAtATime"
  description = "The name of the deployment configuration. All available configurations are listed here: https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html"
}

variable "service_role_arn" {
  type        = string
  description = "The ARN of the IAM role to use for this deployment group"
  default     = ""
}

variable "blue_instance_termination_success_time" {
  type        = number
  default     = 5
  description = "The number of minutes to wait before terminating the blue instances after a successful deployment"
}

variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ECS cluster"
  default     = "default"
}

variable "ecs_service_name" {
  type        = string
  description = "The name of the ECS service"
  default     = "default"
}

variable "prod_lb_listener_arn" {
  type        = list(string)
  description = "The ARN of the prod load balancer listener"
}

variable "test_lb_listener_arn" {
  type        = list(string)
  description = "The ARN of the test load balancer listener"
  default     = []
}

variable "blue_lb_target_group_name" {
  type        = string
  description = "The ARN of the blue load balancer target group"
  default     = ""
}

variable "green_lb_target_group_name" {
  type        = string
  description = "The ARN of the green load balancer target group"
  default     = ""
}

### Auto Create Listenr Inputs ###

variable "load_balancer_arn" {
  type        = string
  description = "The ARN of the load balancer"
}

variable "http_test_listener_port" {
  type        = number
  description = "The http (NOT https) port of the test traffic listener"
  default     = 8080
}

### Target Group Inputs ###
variable "green_target_group_port" {
  type        = number
  description = "The port of the green target group"
  default     = 3000
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "deregistration_delay" {
  type        = number
  description = "The amount of time to wait before deregistering a target"
  default     = 300
}

variable "slow_start" {
  type        = number
  description = "The amount of time to wait before rerouting traffic to a new target"
  default     = 60
}

variable "load_balancing_algorithm_type" {
  type        = string
  description = "The load balancing algorithm to use"
  default     = "round_robin"
}

variable "target_group_health_check_enabled" {
  type        = bool
  description = "Whether or not to enable health checks on the target group"
  default     = true
}

variable "target_group_health_check_interval" {
  type        = number
  description = "The interval between health checks"
  default     = 30
}

variable "target_group_health_check_path" {
  type        = string
  description = "The path to check for health"
  default     = "/"
}

variable "target_group_health_check_timeout" {
  type        = number
  description = "The amount of time to wait for a health check response"
  default     = 5
}

variable "target_group_health_check_healthy_threshold" {
  type        = number
  description = "The number of consecutive successful health checks required before considering the target healthy"
  default     = 2
}

variable "target_group_health_check_unhealthy_threshold" {
  type        = number
  description = "The number of consecutive failed health checks required before considering the target unhealthy"
  default     = 2
}

variable "target_group_health_check_matcher" {
  type        = string
  description = "The HTTP response code to use for health checks"
  default     = "200"

}
