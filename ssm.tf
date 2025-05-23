# When encountering 'InvalidDocumentVersion: Version provided for document SSM-SessionManagerRunShell is not latest.'
# Run 'aws ssm delete-document --name SSM-SessionManagerRunShell' and then re-apply Terraform
# https://github.com/hashicorp/terraform-provider-aws/issues/31131
resource "aws_ssm_document" "session_manager_prefs" {
  count           = var.enable_ssm_session_manager ? 1 : 0
  name            = "SSM-SessionManagerRunShell"
  document_type   = "Session"
  document_format = "JSON"

  content = <<DOC
{
    "schemaVersion": "1.0",
    "description": "Document to hold regional settings for Session Manager",
    "sessionType": "Standard_Stream",
    "inputs": {
        "s3BucketName": "${var.s3_bucket_name}",
        "s3KeyPrefix": "${var.s3_key_prefix}",
        "s3EncryptionEnabled": ${var.s3_encryption_enabled ? "true" : "false"},
        "cloudWatchLogGroupName": "${var.cloudwatch_log_group_name}",
        "cloudWatchEncryptionEnabled": ${var.cloudwatch_encryption_enabled ? "true" : "false"},
        "shellProfile": {
          "linux": "/bin/bash"
        }
    }
}
DOC

}
