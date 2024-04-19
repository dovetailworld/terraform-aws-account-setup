# For this to work you need to have an AWS account configured as monitor account

# AWS CloudWatch Observability Access Manager Link
# Allows an AWS account to be connected to a monitor account
resource "aws_oam_link" "this" {
  count          = var.enable_oam ? 1 : 0
  label_template = "$AccountName"
  resource_types = [
    "AWS::CloudWatch::Metric",
    "AWS::Logs::LogGroup",
    "AWS::XRay::Trace",
    "AWS::ApplicationInsights::Application",
    "AWS::InternetMonitor::Monitor"
  ]
  # This identifier is created in the monitoring account
  sink_identifier = var.sink_identifier
}

# CloudWatch Cross Account Sharing Role
# Allows an AWS account to share e.g. CloudWatch data with the monitoring account
resource "aws_iam_role" "cw_cas_role" {
  count = var.enable_oam ? 1 : 0
  name  = "CloudWatch-CrossAccountSharingRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          "AWS" : "arn:aws:iam::${var.monitoring_account}:root"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "xray-readonly-attach" {
  count      = var.enable_oam ? 1 : 0
  role       = aws_iam_role.cw_cas_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "cw-dashboard-attach" {
  count      = var.enable_oam ? 1 : 0
  role       = aws_iam_role.cw_cas_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAutomaticDashboardsAccess"
}

resource "aws_iam_role_policy_attachment" "cw-readonly-attach" {
  count      = var.enable_oam ? 1 : 0
  role       = aws_iam_role.cw_cas_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}
