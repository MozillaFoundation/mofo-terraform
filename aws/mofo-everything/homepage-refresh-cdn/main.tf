# Configure the AWS Provider
provider "aws" {
  version             = "~> 2.0"
  region              = "us-east-1"
  allowed_account_ids = var.allowed_account_ids
  profile             = "mofo-projects-MoFoProjectsAdmin"
}

provider "aws" {
  alias = "everything"
  version             = "~> 2.0"
  region              = "us-east-1"
  allowed_account_ids = var.allowed_account_ids
  profile             = "mofo-MoFoEverythingAdmin"
}
//
//module "terraform-backend" {
//  source = "github.com/mozilla-it/terraform-modules//aws/s3-backend"
//
//  # Set variables
//  backend_bucket         = "terraform-backend-homepage-refresh-redirect"
//  backend_key            = "terraform.tfstate"
//  backend_dynamodb_table = "terraform-backend-homepage-refresh-redirect"
//  read_capacity          = 5
//  write_capacity         = 5
//  region                 = "us-east-1"
//  tags                   = local.tags
//}
//
//terraform {
//  backend "s3" {
//    bucket         = "terraform-backend-homepage-refresh-redirect"
//    key            = "terraform.tfstate"
//    region         = "us-east-1"
//    profile        = "mofo-projects-MoFoProjectsAdmin"
//    dynamodb_table = "terraform-backend-homepage-refresh-redirect"
//  }
//}

locals {
  tags = {
    project     = "homepage-refresh-redirect",
    description = "Managed by Terraform"
  }
  s3_origin_id = "S3-homepage-refresh-org-redirect"
}
