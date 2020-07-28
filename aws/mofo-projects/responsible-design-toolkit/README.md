# Responsible Design Toolkit Terraform Config

This configuration manages infrastructure backing The Responsible Design Toolkit

## Usage

1. Make necessary changes, get them reviewed, and merged
2. Set-up your CLI for AWS - install [awscli](https://pypi.org/project/awscli/) and  [maws](https://pypi.org/project/mozilla-aws-cli-mozilla/), install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install), and get an admin to add you to the correct LDAP group.
3. Use maws to add the required profile to your AWS configuration - `$(maws -o awscli)`
4. Navigate to this directory and execute `terraform init` to sync state from S3.
5. Execute `terraform plan -out tf.plan` to plan the changes.
6. Check the output to confirm the changes are what you expect
7. execute `terraform apply "tf.plan"` and monitor for any unexpected issues.

## Managed resources

* [Cloudfront](./cloudfront.tf)
* [ACM](./acm.tf)
* [S3](./s3.tf)
* [route53](./route53.tf)

## Static resources

### Source code

The source of the website exactly as it should be deployed is stored in `./src`. The repo on GitHub containing the source and build [toolchain is here](https://github.com/mozilla/delight)
