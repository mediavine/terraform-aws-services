### AWS CodeDeploy Application OUTPUTS ###
output "codedeploy_app_name" {
  value       = aws_codedeploy_app.this.name
  description = "Name of the CodeDeploy application"
}
output "codedeploy_app_arn" {
  value       = aws_codedeploy_app.this.arn
  description = "ARN of the CodeDeploy application"
}
output "codedeploy_id" {
  value       = aws_codedeploy_app.this.id
  description = "Amazon's assigned ID for the application"
}
output "codedeploy_application_id" {
  value       = aws_codedeploy_app.this.application_id
  description = "ID of the CodeDeploy application"
}
output "test_target_group_name" {
  value       = length(aws_lb_target_group.lb_http_test_tg) > 0 ? aws_lb_target_group.lb_http_test_tg[0].name : ""
  description = "ARN of the test target group"
}

output "test_listener_arn" {
  value       = length(aws_lb_listener.lb_http_test_listener) > 0 ? aws_lb_listener.lb_http_test_listener[0].arn : ""
  description = "ARN of the test listener"
}

output "green_lb_target_group_name" {
  value = var.green_lb_target_group_name
}

output "lb_http_test_tg_name" {
  value = aws_lb_target_group.lb_http_test_tg[0].name
}

output "lb_http_test_tg_arn" {
  value = aws_lb_target_group.lb_http_test_tg[0].arn
}
