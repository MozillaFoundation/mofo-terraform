resource "aws_iam_role" "iam_for_lambda_slack_endpoint" {
  name = "iam_for_slack_lambda"
  tags = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "return-200" {
  function_name    = "slack-return-200"
  filename         = "./return_200.zip"
  source_code_hash = filebase64sha256("./return_200.zip")
  handler          = "return_200.handler"
  role             = aws_iam_role.iam_for_lambda_slack_endpoint.arn
  runtime          = "python3.7"

  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.cloudwatch-log-group-slack-endpoint]

  tags = local.tags
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.return-200.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api-gateway.execution_arn}/*${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.slack-endpoint.path}"
}
