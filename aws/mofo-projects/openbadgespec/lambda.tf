resource "aws_iam_role" "lambda_edge_exec" {
  name               = "iam_for_obs_lambda"
  tags               = local.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_check_redirects" {
  filename         = local.check_redirects
  source_code_hash = filebase64sha256(local.check_redirects)
  handler          = "check_redirects.handler"
  function_name    = "obs_check_redirects"
  runtime          = "python3.7"
  role             = aws_iam_role.lambda_edge_exec.arn
  publish          = true
  provider         = aws
  tags             = local.tags
}

resource "aws_lambda_function" "lambda_check_response" {
  filename         = local.check_404
  source_code_hash = filebase64sha256(local.check_404)
  handler          = "check_404.handler"
  function_name    = "obs_check_404"
  runtime          = "python3.7"
  role             = aws_iam_role.lambda_edge_exec.arn
  publish          = true
  provider         = aws
  tags             = local.tags
}
