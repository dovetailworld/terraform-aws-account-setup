variable "enable_mfa" {
  type        = bool
  description = "Enable to force MFA usages."
  default     = true
}

variable "enable_admin_group" {
  type        = bool
  description = "Create an admin group."
  default     = true
}

variable "enable_account_password_policy" {
  type        = bool
  description = "Enable custom (strict) password policy."
  default     = true
}

variable "admin_group_name" {
  type        = string
  description = "Name of the admin group."
  default     = "admins"
}

variable "password_reuse_prevention" {
  type        = number
  description = "The number of previous passwords that users are prevented from reusing."
  default     = 1
}

variable "minimum_password_length" {
  type        = number
  description = "Minimum length to require for user passwords."
  default     = 32
}

variable "require_lowercase_characters" {
  type        = bool
  description = "Whether to require lowercase characters for user passwords."
  default     = true
}

variable "require_numbers" {
  type        = bool
  description = "Whether to require numbers for user passwords."
  default     = true
}

variable "require_uppercase_characters" {
  type        = bool
  description = "Whether to require uppercase characters for user passwords."
  default     = true
}

variable "require_symbols" {
  type        = bool
  description = "Whether to require symbols for user passwords."
  default     = true
}

variable "allow_users_to_change_password" {
  type        = bool
  description = "Whether to allow users to change their own password"
  default     = true
}

variable "max_password_age" {
  type        = number
  description = "The number of days that an user password is valid."
  default     = 33
}

variable "hard_expiry" {
  type        = bool
  description = "Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)"
  default     = false
}

variable "enable_read_only_group" {
  type        = bool
  description = "Creates a group with read-only IAM policy assigned to it."
  default     = false
}

variable "read_only_group_name" {
  type        = string
  description = "Name for read-only group."
  default     = "read-only"
}

### CLOUDTRAIL

variable "cloudtrail_bucket" {
  type        = string
  description = "The name of the cloudtrail bucket"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply on the resources"
  default     = {}
}

variable "trail_name" {
  type        = string
  description = "Name of the cloud trail. Required if the cloudtrail is enabled."
}

variable "include_global_service_events" {
  type        = bool
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files. "
  default     = true
}

variable "enable_log_file_validation" {
  type        = bool
  description = "Specifies whether log file integrity validation is enabled."
  default     = true
}

variable "is_multi_region_trail" {
  type        = bool
  description = "Specifies whether the trail is created in the current region or in all regions. "
  default     = true
}

variable "event_selector" {
  type        = list(string)
  description = "Specifies an event selector for enabling data event logging, It needs to be a list of map values. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this map variable"
  default     = []
}

variable "enable_cloudtrail" {
  type        = bool
  description = "Create a default cloudtrail for the account."
  default     = false
}

variable "enable_cloudwatch_logs" {
  type        = bool
  description = "Enable Cloudwatch Logs for Cloudtrail."
  default     = false
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "The name of the cloudwatch log name"
  default     = "CloudTrail/DefaultLogGroup"
}

variable "cloudwatch_iam_policy_name" {
  type        = string
  description = "The name of the policy which is used for the cloudtrail cloudwatch role"
  default     = "terraform-cloudwatch-policy"
}

variable "cloudwatch_iam_role_name" {
  type        = string
  description = "The name of the role which of the cloudtrail cloudwatch role"
  default     = "terraform-cloudwatch-role"
}

variable "enable_monitor_readonly_user" {
  type        = bool
  description = "Create a user that can read monitor metrics (e.g. for grafana)"
  default     = false
}

variable "monitor_readonly_user_name" {
  type        = string
  description = "The user name for the monitor read only user"
  default     = "monitor_readonly"
}

variable "kms_key_id" {
  type        = string
  description = "The arn of the CMK key which is used for encrypting cloudtrail logs"
}

### AWS Config
variable "aws_config_notification_emails" {
  description = "A list of email addresses for that will receive AWS Config changes notifications"
  default     = []
  type        = list(string)
}

variable "enable_aws_config" {
  type        = bool
  description = "Specifies if the AWS Config should be enabled"
  default     = false
}

variable "tag1Key" {
  type        = string
  default     = ""
  description = "Specifies value of the Key for Tag1"
}

variable "enable_rule_require_tag" {
  type        = bool
  description = "Specifies if 'Require Tag' rule should be enabled"
  default     = false
}

variable "enable_rule_require_root_account_MFA" {
  type        = bool
  description = "Specifies if 'Require root account MFA enabled' rule should be enabled"
  default     = false
}

variable "enable_rule_require_cloud_trail" {
  type        = bool
  description = "Specifies if 'Cloud Trail enabled' rule should be enabled"
  default     = false
}

variable "enable_rule_iam_password_policy" {
  type        = bool
  description = "Specifies if 'IAM password policy' rule should be enabled"
  default     = false
}

### SSM Session Manager
variable "enable_ssm_session_manager" {
  type        = bool
  description = "Specifies if the ssm session manager should be enabled"
  default     = false
}

variable "s3_bucket_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of bucket to store session logs. Specifying this enables writing session output to an Amazon S3 bucket."
}

variable "s3_key_prefix" {
  type        = string
  default     = ""
  description = "(Optional) To write output to a sub-folder, enter a sub-folder name."
}

variable "s3_encryption_enabled" {
  type        = bool
  default     = false
  description = "Encrypt log data."
}

variable "cloudwatch_encryption_enabled" {
  type        = bool
  default     = false
  description = "Encrypt log data."
}

variable "s3_bucket_state_file_creation" {
  type        = bool
  default     = false
  description = "Whether to create S3 bucket in the AWS Account to store terraform state file"
}

variable "s3_bucket_state_file_name" {
  type        = string
  default     = ""
  description = "The S3 bucket name which store the terraform state file"
}

variable "dynamodb_tables_creation" {
  type        = bool
  default     = false
  description = "Whether to create dynamodb tables for terraform state file"
}

variable "dynamodb_tables_name" {
  type        = string
  default     = ""
  description = "The dynamodb tables name"
}

variable "enable_oam" {
  type        = bool
  default     = false
  description = "Whether to create resources used for oam"
}

variable "monitoring_account" {
  type        = string
  description = "AWS monitoring account ID"
}

variable "sink_identifier" {
  type        = string
  description = "Sink ID"
}
