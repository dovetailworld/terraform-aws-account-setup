# AWS CloudWatch Observability Access Manager Link
resource "aws_oam_link" "example" {
  label_template  = "$AccountName"
  resource_types  = [
    "AWS::CloudWatch::Metric",
    "AWS::Logs::LogGroup",
    "AWS::XRay::Trace",
    "AWS::ApplicationInsights::Application",
    "AWS::InternetMonitor::Monitor"
    ]
  sink_identifier = aws_oam_sink.test.id
}
