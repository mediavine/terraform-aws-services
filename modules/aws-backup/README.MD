# 🌍 Cross-Region RDS Backup (Terraform Module)

This Terraform module sets up a **cross-region RDS backup strategy** using AWS Backup. It creates:

- Backup vaults in both source and destination regions
- A backup plan with daily scheduling and lifecycle policies
- A cross-region copy rule to replicate backups to a secondary region
- An IAM role required for AWS Backup to operate
- Resource selection to associate RDS instances with the backup plan

---

## ✅ Features

- 🔁 Cross-region backup copy for disaster recovery
- ⏰ Daily scheduled backups via cron expressions
- ♻️ Retention lifecycle policy for automatic deletion
- 🔒 IAM role with appropriate AWS Backup permissions
- 🧩 Modular and reusable with minimal inputs

---

## 📦 Module Usage

```hcl
module "cross_region_backup" {
  source = "./modules/cross_region_rds_backup"

  name_prefix        = "rds-cross" # Naming convention for created resources
  source_region      = "us-east-1"
  destination_region = "us-west-2"

  rds_resource_arns = [
    "arn:aws:rds:us-west-1:123456789012:db:my-db-instance"
  ]

  backup_schedule = "cron(0 8 * * ? *)"  # Optional - default is daily at 8 AM UTC (3 AM EST in Winter and 4 AM EST in Summer)
  retention_days  = 15                   # Optional - default is 15 days
}
