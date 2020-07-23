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
  backend_bucket         = "terraform-backend-openbadgespec"
  backend_key            = "terraform.tfstate"
  backend_dynamodb_table = "terraform-backend-openbadgespec"
  read_capacity          = 5
  write_capacity         = 5
  region                 = "us-east-1"
  tags                   = local.tags
}

terraform {
  backend "s3" {
    bucket         = "terraform-backend-openbadgespec"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "mofo-projects-MoFoProjectsAdmin"
    dynamodb_table = "terraform-backend-openbadgespec"
  }
}

locals {
  tags = {
    project     = "openbadgespec",
    description = "Managed by Terraform"
  }
  staticfiles_dir = "${path.module}/staticfiles"
  check_redirects = "${path.module}/lambda/check_redirects.zip"
  check_404       = "${path.module}/lambda/check_404.zip"
  s3_origin_id    = "obsS3Origin"
}
