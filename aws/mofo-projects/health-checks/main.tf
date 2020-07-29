# Configure the AWS Provider
provider "aws" {
  version             = "~> 2.0"
  region              = "us-east-1"
  allowed_account_ids = var.allowed_account_ids
  profile             = "mofo-projects-MoFoProjectsAdmin"
}

module "terraform-backend" {
  source = "github.com/mozilla-it/terraform-modules//aws/s3-backend"

  # Set variables
  backend_bucket         = "terraform-backend-health-checks"
  backend_key            = "terraform.tfstate"
  backend_dynamodb_table = "terraform-backend-health-checks"
  read_capacity          = 5
  write_capacity         = 5
  region                 = "us-east-1"
  tags                   = local.tags
}

terraform {
  backend "s3" {
    bucket         = "terraform-backend-health-checks"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "mofo-projects-MoFoProjectsAdmin"
    dynamodb_table = "terraform-backend-health-checks"
  }
}


locals {
  tags = {
    project     = "health-checks",
    description = "Managed by Terraform"
  }
}
