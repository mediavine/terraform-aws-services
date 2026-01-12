data "aws_caller_identity" "current" {}

locals {
  create_bucket = var.s3_bucket_name == null
  bucket_name   = local.create_bucket ? "${var.name}-dns-resolver-logs-${data.aws_caller_identity.current.account_id}" : var.s3_bucket_name
}

resource "aws_s3_bucket" "dns_logs" {
  #checkov:skip=CKV2_AWS_62: Will do at a later time
  #checkov:skip=CKV_AWS_18: Will do at a later time
  count  = local.create_bucket ? 1 : 0
  bucket = local.bucket_name

  tags = merge(var.tags, {
    Name = local.bucket_name
  })
}

resource "aws_s3_bucket_lifecycle_configuration" "dns_logs" {
  count  = local.create_bucket && var.log_retention_days > 0 ? 1 : 0
  bucket = aws_s3_bucket.dns_logs[0].id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = var.log_retention_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "dns_logs" {
  count  = local.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.dns_logs[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "dns_logs_bucket_policy" {
  statement {
    sid    = "AllowRoute53ResolverLogging"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "AllowRoute53ResolverGetBucketAcl"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_s3_bucket_policy" "dns_logs" {
  count  = local.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.dns_logs[0].id
  policy = data.aws_iam_policy_document.dns_logs_bucket_policy.json

  depends_on = [aws_s3_bucket_public_access_block.dns_logs]
}

resource "aws_route53_resolver_query_log_config" "this" {
  name            = var.name
  destination_arn = local.create_bucket ? aws_s3_bucket.dns_logs[0].arn : "arn:aws:s3:::${var.s3_bucket_name}"

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.dns_logs]
}

resource "aws_route53_resolver_query_log_config_association" "this" {
  for_each = toset(var.vpc_ids)

  resolver_query_log_config_id = aws_route53_resolver_query_log_config.this.id
  resource_id                  = each.value
}
