# Backup Vault Resource

resource "aws_backup_vault" "my_vault" {
  name        = "my-backup-vault"

}

# Backup Vault Policy

data "aws_iam_policy_document" "vault_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "backup:DescribeBackupVault",
      "backup:DeleteBackupVault",
      "backup:PutBackupVaultAccessPolicy",
      "backup:DeleteBackupVaultAccessPolicy",
      "backup:GetBackupVaultAccessPolicy",
      "backup:StartBackupJob",
      "backup:GetBackupVaultNotifications",
      "backup:PutBackupVaultNotifications",
    ]

    resources = [aws_backup_vault.my_vault.arn]
  }
}

resource "aws_backup_vault_policy" "vault_pol" {
  backup_vault_name = aws_backup_vault.my_vault.name
  policy            = data.aws_iam_policy_document.vault_policy.json
}