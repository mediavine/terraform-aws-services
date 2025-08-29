output "backup_vault_source" {
  value = aws_backup_vault.source.name
}

output "backup_vault_destination" {
  value = aws_backup_vault.destination.name
}

output "backup_plan_id" {
  value = aws_backup_plan.plan.id
}

output "backup_selection_name" {
  value = aws_backup_selection.selection.name
}
