# S3 backend variables
variable "allowed_account_ids" {
  description = "List of allowed AWS account ids where resources can be created"
  type        = list
  default     = []
}

variable "profile" {
  description = "Name of the AWS profile"
  type        = string
  default     = ""
}

# Heroku provider variables
variable "heroku_team_name" {
  description = "Name of the Heroku Team owning this complete deployment."
  type        = string
}

variable "auth_email" {
  description = "Email used to authenticate user on Heroku"
  type        = string
}

variable "auth_token" {
  description = "Token used to authenticate user on Heroku"
  type        = string
}

# Heroku config
variable "scalyr_drain" {
  description = "Log drain for Scalyr"
  type        = string
}

# Environment variables
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS_ACCESS_KEY_ID"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS_SECRET_ACCESS_KEY"
  type        = string
}

variable "CLOUDINARY_API_KEY" {
  description = "CLOUDINARY_API_KEY"
  type        = string
}

variable "CLOUDINARY_API_SECRET" {
  description = "CLOUDINARY_API_KEY"
  type        = string
}

variable "CRM_AWS_SQS_ACCESS_KEY_ID" {
  description = "CRM_AWS_SQS_ACCESS_KEY_ID"
  type        = string
}

variable "CRM_AWS_SQS_SECRET_ACCESS_KEY" {
  description = "CRM_AWS_SQS_SECRET_ACCESS_KEY"
  type        = string
}

variable "CRM_PETITION_SQS_QUEUE_URL" {
  description = "CRM_PETITION_SQS_QUEUE_URL"
  type        = string
}

variable "DJANGO_SECRET_KEY" {
  description = "DJANGO_SECRET_KEY"
  type        = string
}

variable "SENTRY_DSN" {
  description = "SENTRY_DSN"
  type        = string
}

variable "SOCIAL_AUTH_GOOGLE_OAUTH2_KEY" {
  description = "SOCIAL_AUTH_GOOGLE_OAUTH2_KEY"
  type        = string
}

variable "SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET" {
  description = "SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET"
  type        = string
}
