variable "name" {
  description = "Name prefix for resources created by this module"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to store DNS query logs. If not provided, a bucket will be created."
  type        = string
  default     = null
}

variable "vpc_ids" {
  description = "List of VPC IDs to associate with the Resolver query log config"
  type        = list(string)
}

variable "log_retention_days" {
  description = "Number of days to retain logs in S3 (lifecycle rule). Set to 0 to disable lifecycle rule."
  type        = number
  default     = 90
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
