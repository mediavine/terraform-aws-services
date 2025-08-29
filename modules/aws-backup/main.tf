# Backup Vaults
resource "aws_backup_vault" "source" {
  provider = aws.source
  name     = "${var.name_prefix}-vault-source"
}

resource "aws_backup_vault" "destination" {
  provider = aws.destination
  name     = "${var.name_prefix}-vault-destination"
}

# IAM Role
resource "aws_iam_role" "backup_role" {
  name = "${var.name_prefix}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "backup.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# Backup Plan
resource "aws_backup_plan" "plan" {
  name = "${var.name_prefix}-plan"

  rule {
    rule_name         = "${var.name_prefix}-daily-backup"
    target_vault_name = aws_backup_vault.source.name
    schedule          = var.backup_schedule
    start_window      = 60
    completion_window = 180

    lifecycle {
      delete_after = var.retention_days
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.destination.arn
      lifecycle {
        delete_after = var.retention_days
      }
    }
  }
}

# Backup Selection
resource "aws_backup_selection" "selection" {
  name         = "${var.name_prefix}-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.plan.id

  resources = var.rds_resource_arns
}
