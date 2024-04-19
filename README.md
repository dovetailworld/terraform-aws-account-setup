# Terraform module configure IAM in a new Amazon account_setup

> ⚠️ 👉🏻 These instruction are outdated, certain features might have been removed or added.

This terraform modules configures the following in IAM:

- Creates a policy to enforce MFA
- Sets a script password policy
- Creates a group with admin privileges, with MFA enable_admin_group
- Creates a group with read-only policy (disabled by default)
- Creates a global cloud trail (disabled by default)
- Creates a user including access keys for monitoring purposes (disabled by default)

All features can be enabled or disabled, default is enabled.

The following AWS Config rules can be enabled (AWS Config is disabled by default, each rule can be enabled individually):

- Require a specific tag on the resources<sup>1</sup>
- Require root account MFA enabled
- Cloud trail enabled
- IAM password policy compliance

<sup>1</sup>Terraform does not allow passing unset value similar to `!Ref "AWS::NoValue"`. Due to this limitation only a single tag `tag1Key` can be passed as a parameter to to this module. If you require additional key-value pairs in your AWS config REQUIRED_TAGS rule, the module must be extended manually.

## Usage

### Example usages

> ⚠️ 👉🏻 This an example, it might be that certain settings are not 'best-practise'.

```terraform
module "account_setup" {
  source = "git@github.com:dovetailworld/terraform-aws-account-setup.git?ref=<version>"

  # iam
  enable_account_password_policy = false
  enable_read_only_group         = false
  enable_admin_group             = false

  # cloudtrail
  enable_cloudtrail = true
  cloudtrail_bucket = ""
  kms_key_id        = ""
  trail_name        = local.account-name

  # cloudwatch
  enable_cloudwatch_logs = true

  # oam
  # Note: Do not enable this on the monitoring account itself!
  enable_oam         = true
  sink_identifier    = ""
  monitoring_account = ""

  # config
  enable_aws_config                    = false
  enable_rule_require_tag              = false
  enable_rule_require_root_account_MFA = false
  enable_rule_iam_password_policy      = false
  enable_rule_require_cloud_trail      = false

  # ssm session manager
  enable_ssm_session_manager = true
  s3_bucket_name             = ""
  s3_key_prefix              = "${local.account-id}-${local.account-name}"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_config_config_rule.cloud_trail_enabled_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.iam_password_policy_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.require_root_account_MFA_enabled_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.require_tag_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_configuration_recorder.aws_config_recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.aws_config_recorder_status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.aws_config_delivery_channel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_dynamodb_table.kabisa_terraform_lockfiles_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_iam_access_key.monitor_readonly_user_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_account_password_policy.pasword_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_group.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group.read-only-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.read-only-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.cloudwatch_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.monitor_readonly_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_config_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cloudwatch_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cw_cas_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.aws_config_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.aws_config_iam_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_iam_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cw-dashboard-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cw-readonly-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.xray-readonly-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.monitor_readonly_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_kms_key.cloudtrail_bucket_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_oam_link.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_link) | resource |
| [aws_s3_bucket.aws_config_configuration_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.kabisa_terraform_statefiles_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.s3_bucket_private_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.s3_bucket_encrypt_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versioning_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_sns_topic.aws_config_updates_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_ssm_document.session_manager_prefs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document) | resource |
| [null_resource.sns_subscribe](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.aws_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_config_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.force_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.monitor_readonly_user_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group_name"></a> [admin\_group\_name](#input\_admin\_group\_name) | Name of the admin group. | `string` | `"admins"` | no |
| <a name="input_allow_users_to_change_password"></a> [allow\_users\_to\_change\_password](#input\_allow\_users\_to\_change\_password) | Whether to allow users to change their own password | `bool` | `true` | no |
| <a name="input_aws_config_notification_emails"></a> [aws\_config\_notification\_emails](#input\_aws\_config\_notification\_emails) | A list of email addresses for that will receive AWS Config changes notifications | `list(string)` | `[]` | no |
| <a name="input_cloudtrail_bucket"></a> [cloudtrail\_bucket](#input\_cloudtrail\_bucket) | The name of the cloudtrail bucket | `string` | n/a | yes |
| <a name="input_cloudwatch_encryption_enabled"></a> [cloudwatch\_encryption\_enabled](#input\_cloudwatch\_encryption\_enabled) | Encrypt log data. | `bool` | `false` | no |
| <a name="input_cloudwatch_iam_policy_name"></a> [cloudwatch\_iam\_policy\_name](#input\_cloudwatch\_iam\_policy\_name) | The name of the policy which is used for the cloudtrail cloudwatch role | `string` | `"terraform-cloudwatch-policy"` | no |
| <a name="input_cloudwatch_iam_role_name"></a> [cloudwatch\_iam\_role\_name](#input\_cloudwatch\_iam\_role\_name) | The name of the role which of the cloudtrail cloudwatch role | `string` | `"terraform-cloudwatch-role"` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | The name of the cloudwatch log name | `string` | `"CloudTrail/DefaultLogGroup"` | no |
| <a name="input_dynamodb_tables_creation"></a> [dynamodb\_tables\_creation](#input\_dynamodb\_tables\_creation) | Whether to create dynamodb tables for terraform state file | `bool` | `false` | no |
| <a name="input_dynamodb_tables_name"></a> [dynamodb\_tables\_name](#input\_dynamodb\_tables\_name) | The dynamodb tables name | `string` | n/a | yes |
| <a name="input_enable_account_password_policy"></a> [enable\_account\_password\_policy](#input\_enable\_account\_password\_policy) | Enable custom (strict) password policy. | `bool` | `true` | no |
| <a name="input_enable_admin_group"></a> [enable\_admin\_group](#input\_enable\_admin\_group) | Create an admin group. | `bool` | `true` | no |
| <a name="input_enable_aws_config"></a> [enable\_aws\_config](#input\_enable\_aws\_config) | Specifies if the AWS Config should be enabled | `bool` | `false` | no |
| <a name="input_enable_cloudtrail"></a> [enable\_cloudtrail](#input\_enable\_cloudtrail) | Create a default cloudtrail for the account. | `bool` | `false` | no |
| <a name="input_enable_cloudwatch_logs"></a> [enable\_cloudwatch\_logs](#input\_enable\_cloudwatch\_logs) | Enable Cloudwatch Logs for Cloudtrail. | `bool` | `false` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Specifies whether log file integrity validation is enabled. | `bool` | `true` | no |
| <a name="input_enable_mfa"></a> [enable\_mfa](#input\_enable\_mfa) | Enable to force MFA usages. | `bool` | `true` | no |
| <a name="input_enable_monitor_readonly_user"></a> [enable\_monitor\_readonly\_user](#input\_enable\_monitor\_readonly\_user) | Create a user that can read monitor metrics (e.g. for grafana) | `bool` | `false` | no |
| <a name="input_enable_oam"></a> [enable\_oam](#input\_enable\_oam) | Whether to create resources used for oam | `bool` | `false` | no |
| <a name="input_enable_read_only_group"></a> [enable\_read\_only\_group](#input\_enable\_read\_only\_group) | Creates a group with read-only IAM policy assigned to it. | `bool` | `false` | no |
| <a name="input_enable_rule_iam_password_policy"></a> [enable\_rule\_iam\_password\_policy](#input\_enable\_rule\_iam\_password\_policy) | Specifies if 'IAM password policy' rule should be enabled | `bool` | `false` | no |
| <a name="input_enable_rule_require_cloud_trail"></a> [enable\_rule\_require\_cloud\_trail](#input\_enable\_rule\_require\_cloud\_trail) | Specifies if 'Cloud Trail enabled' rule should be enabled | `bool` | `false` | no |
| <a name="input_enable_rule_require_root_account_MFA"></a> [enable\_rule\_require\_root\_account\_MFA](#input\_enable\_rule\_require\_root\_account\_MFA) | Specifies if 'Require root account MFA enabled' rule should be enabled | `bool` | `false` | no |
| <a name="input_enable_rule_require_tag"></a> [enable\_rule\_require\_tag](#input\_enable\_rule\_require\_tag) | Specifies if 'Require Tag' rule should be enabled | `bool` | `false` | no |
| <a name="input_enable_ssm_session_manager"></a> [enable\_ssm\_session\_manager](#input\_enable\_ssm\_session\_manager) | Specifies if the ssm session manager should be enabled | `bool` | `false` | no |
| <a name="input_event_selector"></a> [event\_selector](#input\_event\_selector) | Specifies an event selector for enabling data event logging, It needs to be a list of map values. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this map variable | `list(string)` | `[]` | no |
| <a name="input_hard_expiry"></a> [hard\_expiry](#input\_hard\_expiry) | Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) | `bool` | `false` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | Specifies whether the trail is publishing events from global services such as IAM to the log files. | `bool` | `true` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | Specifies whether the trail is created in the current region or in all regions. | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The arn of the CMK key which is used for encrypting cloudtrail logs | `string` | n/a | yes |
| <a name="input_max_password_age"></a> [max\_password\_age](#input\_max\_password\_age) | The number of days that an user password is valid. | `number` | `33` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum length to require for user passwords. | `number` | `32` | no |
| <a name="input_monitor_readonly_user_name"></a> [monitor\_readonly\_user\_name](#input\_monitor\_readonly\_user\_name) | The user name for the monitor read only user | `string` | `"monitor_readonly"` | no |
| <a name="input_monitoring_account"></a> [monitoring\_account](#input\_monitoring\_account) | AWS monitoring account ID | `string` | n/a | yes |
| <a name="input_password_reuse_prevention"></a> [password\_reuse\_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing. | `number` | `1` | no |
| <a name="input_read_only_group_name"></a> [read\_only\_group\_name](#input\_read\_only\_group\_name) | Name for read-only group. | `string` | `"read-only"` | no |
| <a name="input_require_lowercase_characters"></a> [require\_lowercase\_characters](#input\_require\_lowercase\_characters) | Whether to require lowercase characters for user passwords. | `bool` | `true` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether to require numbers for user passwords. | `bool` | `true` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether to require symbols for user passwords. | `bool` | `true` | no |
| <a name="input_require_uppercase_characters"></a> [require\_uppercase\_characters](#input\_require\_uppercase\_characters) | Whether to require uppercase characters for user passwords. | `bool` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | (Optional) The name of bucket to store session logs. Specifying this enables writing session output to an Amazon S3 bucket. | `string` | `""` | no |
| <a name="input_s3_bucket_state_file_creation"></a> [s3\_bucket\_state\_file\_creation](#input\_s3\_bucket\_state\_file\_creation) | Whether to create S3 bucket in the AWS Account to store terraform state file | `bool` | `false` | no |
| <a name="input_s3_bucket_state_file_name"></a> [s3\_bucket\_state\_file\_name](#input\_s3\_bucket\_state\_file\_name) | The S3 bucket name which store the terraform state file | `string` | n/a | yes |
| <a name="input_s3_encryption_enabled"></a> [s3\_encryption\_enabled](#input\_s3\_encryption\_enabled) | Encrypt log data. | `bool` | `false` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | (Optional) To write output to a sub-folder, enter a sub-folder name. | `string` | `""` | no |
| <a name="input_sink_identifier"></a> [sink\_identifier](#input\_sink\_identifier) | Sink ID | `string` | n/a | yes |
| <a name="input_tag1Key"></a> [tag1Key](#input\_tag1Key) | Specifies value of the Key for Tag1 | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply on the resources | `map(string)` | `{}` | no |
| <a name="input_trail_name"></a> [trail\_name](#input\_trail\_name) | Name of the cloud trail. Required if the cloudtrail is enabled. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Cloud trail arn. |
| <a name="output_mfa_policy_arn"></a> [mfa\_policy\_arn](#output\_mfa\_policy\_arn) | MFA Policy arn. |
| <a name="output_monitor_readonly_user_access_key_id"></a> [monitor\_readonly\_user\_access\_key\_id](#output\_monitor\_readonly\_user\_access\_key\_id) | Access key id for the monitor readonly user |
| <a name="output_monitor_readonly_user_arn"></a> [monitor\_readonly\_user\_arn](#output\_monitor\_readonly\_user\_arn) | ARN for the monitor readonly user |
| <a name="output_monitor_readonly_user_secret_access_key"></a> [monitor\_readonly\_user\_secret\_access\_key](#output\_monitor\_readonly\_user\_secret\_access\_key) | Secret access key for the monitor readonly user |
| <a name="output_trail_arn"></a> [trail\_arn](#output\_trail\_arn) | Cloud trail arn. |
<!-- END_TF_DOCS -->
