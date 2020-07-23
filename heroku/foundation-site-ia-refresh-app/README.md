# Terraform for `foundation-site-ia-refresh-app` (Heroku app)

## Setup

**Get the secret envs:**
- Copy the `default.vars` file and create a `terraform.tfvars` file.
- Fill the blanks.
- Connect your local machine to the Terraform S3 backend by using `maws` and select the `mofo-project` account.

## Apply changes

- `terraform plan -out tf.plan`: export the changes terraform plans to apply to a `tf.plan` file.
- `terraform apply tf.plan`: if you agree with the plan, you can apply it that way.
