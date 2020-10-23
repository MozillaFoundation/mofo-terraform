# Mofo Terraform

Terraform code for MoFo's infrastructure.

## How to use

- Set-up your CLI for AWS - install `awscli` and `maws`, install Terraform, and get an team member to add you to the correct LDAP group on people.mozilla.org.
- Use maws to add the required profile to your AWS configuration - `$(maws -o awscli)`
- Navigate to the directory you want to work in and execute `terraform init` to sync state from S3.
- Execute `terraform plan -out tf.plan` to plan the changes.
- Check the output to confirm the changes are what you expect
- execute `terraform apply "tf.plan"` and monitor for any unexpected issues.

## Pre-commit hooks

- Install the pre-commit framework: `pipx install pre-commit` or `brew install pre-commit`.
- Run `pre-commit install`

You can test your installation by running `pre-commit run -a`: this will run all the pre-commit hooks. After that, pre-commit hooks will only run on changed files.

**Current hooks:**
- `trailing-whitespace`: Trims trailing whitespace.
- `check-case-conflict`: Check for files with names that would conflict on a case-insensitive filesystem like MacOS HFS+ or Windows FAT.
- `check-merge-conflict`: Check for files that contain merge conflict strings.
- `detect-secrets`: Check for secrets. Configuration is defined in `.secrets.baseline`. To update that file, run `detect-secrets scan --update .secrets.baseline`.
- `terraform_fmt`: run `terraform fmt` on all new or modified terraform files.
