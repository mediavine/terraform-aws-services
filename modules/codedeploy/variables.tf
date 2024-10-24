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

variable "prod_lb_listener_arns" {
  type        = list(string)
  description = "The ARNs of the prod load balancer listener"
}

variable "test_lb_listener_arns" {
  type        = list(string)
  description = "The ARNs of the test load balancer listener"
}

variable "blue_lb_target_group_arn" {
  type        = string
  description = "The ARN of the blue load balancer target group"
}

variable "green_lb_target_group_arn" {
  type        = string
  description = "The ARN of the green load balancer target group"
}
