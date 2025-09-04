output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group for DNS query logging"
  value       = aws_cloudwatch_log_group.dns_query_logging.name
}

output "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group for DNS query logging"
  value       = aws_cloudwatch_log_group.dns_query_logging.arn
}

output "route53_query_log_id" {
  description = "The ID of the Route 53 query log"
  value       = aws_route53_query_log.this.id
}
