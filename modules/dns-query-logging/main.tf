resource "aws_cloudwatch_log_group" "dns_query_logging" {
  name              = "/aws/route53/${var.route53_zone_name}"
  retention_in_days = var.retention_in_days
}

resource "aws_route53_query_log" "this" {
  depends_on = [aws_cloudwatch_log_resource_policy.route53-query-logging-policy]

  cloudwatch_log_group_arn = aws_cloudwatch_log_group.dns_query_logging.arn
  zone_id                  = var.route53_zone_id
}
