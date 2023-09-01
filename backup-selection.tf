data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

}

# IAM Role

resource "aws_iam_role" "my_bck_up_role" {
  name               = "my-backup-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


# Policy Attachement

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.my_bck_up_role.name
}

# Seletcting Backup by resource

resource "aws_backup_selection" "myselection" {
  iam_role_arn = aws_iam_role.my_bck_up_role.arn
  name         = "test_selection"
  plan_id      = aws_backup_plan.my_back_plan.id

  resources = [
    "arn:aws:ec2:aws-region:aws-account-number:instance/your-instance-id"
    
  ]
}
