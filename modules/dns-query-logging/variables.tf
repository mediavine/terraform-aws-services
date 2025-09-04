variable "route53_zone_name" {
  description = "The name of the Route 53 zone to log DNS queries for"
  type        = string
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 zone to log DNS queries for"
  type        = string
}

variable "retention_in_days" {
  description = "The number of days to retain the logs"
  type        = number
}
