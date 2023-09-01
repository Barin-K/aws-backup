# Backup Plan Resource 

resource "aws_backup_plan" "my_back_plan" {
  name = "my-backup-plan"

  rule {
    rule_name         = "my-backup-rule"
    target_vault_name = aws_backup_vault.my_vault.name
    schedule          = "cron(0 11 * * ? *)"
    completion_window = 60

    lifecycle {
      delete_after = 14
    }
  }
}  
