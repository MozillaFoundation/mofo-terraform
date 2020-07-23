# Mofo Terraform

Terraform code for MoFo's infrastructure.

## How to use

- `terraform plan -out tf.plan`: export the changes terraform plans to apply to a `tf.plan` file.
- `terraform apply tf.plan`: if you agree with the plan, you can apply it that way.

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
