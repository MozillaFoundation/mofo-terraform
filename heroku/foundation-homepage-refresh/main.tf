# Configure the AWS Provider
provider "aws" {
  version             = "~> 2.0"
  region              = "us-east-1"
  allowed_account_ids = var.allowed_account_ids
  profile             = var.profile
}

# # Configure the Terraform backend
module "terraform-backend" {
  source = "github.com/mozilla-it/terraform-modules//aws/s3-backend"

  # Set variables
  backend_bucket         = "terraform-backend-heroku-foundation-homepage-refresh"
  backend_key            = "terraform.tfstate"
  backend_dynamodb_table = "terraform-backend-heroku-foundation-homepage-refresh"
  read_capacity          = 5
  write_capacity         = 5
  region                 = "us-east-1"
  tags = {
    project     = "foundation-homepage-refresh",
    description = "Managed by Terraform"
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-backend-heroku-foundation-homepage-refresh"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "mofo-projects-MoFoProjectsAdmin"
    dynamodb_table = "terraform-backend-heroku-foundation-homepage-refresh"
  }
}

# Configure the Heroku Provider
provider "heroku" {
  version = "~> 2.0"
  email   = var.auth_email
  api_key = var.auth_token
}

