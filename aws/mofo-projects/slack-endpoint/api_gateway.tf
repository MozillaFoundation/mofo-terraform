resource "aws_api_gateway_rest_api" "api-gateway" {
  name        = "slack-endpoint-api"
  description = "Process events from Slack"
}

resource "aws_api_gateway_resource" "slack-endpoint" {
  parent_id   = aws_api_gateway_rest_api.api-gateway.root_resource_id
  path_part   = "slack-endpoint"
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
  resource_id = aws_api_gateway_resource.slack-endpoint.id

  # Slack sends a POST request
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  http_method = aws_api_gateway_method.method.http_method
  resource_id = aws_api_gateway_resource.slack-endpoint.id
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id

  # Must be POST
  integration_http_method = "POST"

  type = "AWS_PROXY"
  uri  = aws_lambda_function.return-200.invoke_arn
}

resource "aws_api_gateway_integration_response" "integration-response" {
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
  resource_id = aws_api_gateway_resource.slack-endpoint.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id     = aws_api_gateway_rest_api.api-gateway.id
  resource_id     = aws_api_gateway_resource.slack-endpoint.id
  http_method     = aws_api_gateway_method.method.http_method
  status_code     = "200"
  response_models = { "application/json" : "Empty" }
}

resource "aws_api_gateway_deployment" "prod_deploy" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
  stage_name  = "prod"
}
