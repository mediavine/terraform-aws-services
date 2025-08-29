variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "source_region" {
  description = "Primary AWS region"
  type        = string
}

variable "destination_region" {
  description = "Destination AWS region for cross-region copy"
  type        = string
}

variable "rds_resource_arns" {
  description = "List of RDS instance ARNs to back up"
  type        = list(string)
}

variable "backup_schedule" {
  description = "Cron expression for backup schedule. Default is daily at 8 AM UTC (3 AM EST in Winter and 4 AM EST in Summer)"
  type        = string
  default     = "cron(0 8 * * ? *)"
}

variable "retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}
