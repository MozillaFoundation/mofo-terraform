# openbadgespec.org Terraform Config

This configuration manages infrastructure backing openbadgespec.org and www.openbadgespec.org

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
* [Lambda](./lambda.tf)
* [S3](./s3.tf)
* [route53](./route53.tf)

## Static resources

### Lambda functions

These functions handle cases where we want to redirect to the IMS global site. To update these, make changes to the functions, and update the corresponding file in the zip, as this is the file that's actually deployed to AWS Lambda, and it detects changes using file hashes.

### JSON files

These are the legacy badge specifications and validation files that must be maintained to keep existing badge infrastructure running. In general we don't want to touch these. Any files added to this folder are automatically created in S3 when generating and executing a plan.
