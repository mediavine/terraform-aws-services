# Example usage of the DNS Query Logging module

# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Route 53 is global, but CloudWatch Logs are regional
}

# Create a Route 53 hosted zone (optional - you can use an existing one)
# resource "aws_route53_zone" "example" {
#   name = var.domain_name
# }

# Use the DNS Query Logging module
# module "dns_query_logging" {
#   source = "../../modules/dns-query-logging"

#   route53_zone_name = aws_route53_zone.example.name
#   route53_zone_id   = aws_route53_zone.example.zone_id
#   retention_in_days = var.log_retention_days
# }

#Example: If you want to use an existing Route 53 zone instead
module "dns_query_logging_existing" {
  source = "../../modules/dns-query-logging"

  route53_zone_name = "example.com"
  route53_zone_id   = "Z1234567890ABC" # Your existing zone ID
  retention_in_days = 30
}
