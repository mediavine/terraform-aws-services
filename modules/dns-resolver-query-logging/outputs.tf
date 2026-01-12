output "s3_bucket_name" {
  description = "The name of the S3 bucket storing DNS query logs"
  value       = local.bucket_name
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket storing DNS query logs"
  value       = local.create_bucket ? aws_s3_bucket.dns_logs[0].arn : "arn:aws:s3:::${var.s3_bucket_name}"
}

output "resolver_query_log_config_id" {
  description = "The ID of the Route 53 Resolver query log config"
  value       = aws_route53_resolver_query_log_config.this.id
}

output "resolver_query_log_config_arn" {
  description = "The ARN of the Route 53 Resolver query log config"
  value       = aws_route53_resolver_query_log_config.this.arn
}

output "vpc_associations" {
  description = "Map of VPC IDs to their query log config association IDs"
  value       = { for k, v in aws_route53_resolver_query_log_config_association.this : k => v.id }
}
