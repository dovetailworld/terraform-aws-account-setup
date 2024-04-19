# AWS CloudWatch Observability Access Manager Link
resource "aws_oam_link" "this" {
  label_template = "$AccountName"
  resource_types = [
    "AWS::CloudWatch::Metric",
    "AWS::Logs::LogGroup",
    "AWS::XRay::Trace",
    "AWS::ApplicationInsights::Application",
    "AWS::InternetMonitor::Monitor"
  ]
  sink_identifier = var.sink_identifier
}
