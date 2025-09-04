# # Outputs from the DNS Query Logging module example

# output "route53_zone_id" {
#   description = "The ID of the Route 53 hosted zone"
#   value       = aws_route53_zone.example.zone_id
# }

# output "route53_zone_name" {
#   description = "The name of the Route 53 hosted zone"
#   value       = aws_route53_zone.example.name
# }

# output "cloudwatch_log_group_name" {
#   description = "The name of the CloudWatch log group for DNS query logging"
#   value       = module.dns_query_logging.cloudwatch_log_group_name
# }

# output "cloudwatch_log_group_arn" {
#   description = "The ARN of the CloudWatch log group for DNS query logging"
#   value       = module.dns_query_logging.cloudwatch_log_group_arn
# }

# output "route53_query_log_id" {
#   description = "The ID of the Route 53 query log"
#   value       = module.dns_query_logging.route53_query_log_id
# }
