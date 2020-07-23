resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda_slack_endpoint.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-slack-endpoint" {
  name              = "/aws/lambda/slack-return-200"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "usage-alert" {
  alarm_name          = "lambda-slack-endpoint-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "200"
  alarm_description   = "Lambda was executed more than 200 times in the last 5 minutes"

  dimensions = {
    FunctionName = aws_lambda_function.return-200.function_name
  }

  alarm_actions = [data.aws_sns_topic.mofo-devops-email.arn]

}

data "aws_sns_topic" "mofo-devops-email" {
  name = "devops_mofo"
}
