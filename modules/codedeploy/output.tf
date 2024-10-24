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
