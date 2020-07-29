# Paging alerts are sent to victorops
data "aws_sns_topic" "victorops-integration" {
  name = "VictorOps"
}

# Non-paging alerts are sent to the mofo devops mailing list
data "aws_sns_topic" "mofo-devops-email" {
  name = "devops_mofo"
}

# CloudWatch's alerts
resource "aws_cloudwatch_metric_alarm" "health-checks-victorops-alerts" {
  for_each = var.high-priority-services

  alarm_name          = "${each.key}-health-check-failed"
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "6"
  datapoints_to_alarm = "6"
  period              = "300"
  statistic           = "Minimum"
  threshold           = "1"
  alarm_description   = "last 3 health-checks failed for ${each.key} (30 minutes downtime)"

  dimensions = {
    HealthCheckId = aws_route53_health_check.health-checks[each.key].id
  }

  alarm_actions = [data.aws_sns_topic.victorops-integration.arn]

  tags = local.tags
}

# Services' health-checks
resource "aws_route53_health_check" "health-checks" {
  for_each = var.high-priority-services

  fqdn              = each.value
  port              = 443
  type              = "HTTPS"
  resource_path     = "/"
  failure_threshold = "10"
  request_interval  = "30"
  regions           = ["eu-west-1", "us-east-1", "us-west-1"]
  measure_latency   = true

  tags = local.tags
}

