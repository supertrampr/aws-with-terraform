# First project

This folder contains a [Terraform](https://developer.hashicorp.com/terraform) configuration that shows what usually is needed to run a basic configuration.

## Requirements

- [terraform](https://developer.hashicorp.com/terraform/install) >= 1.13.0;

## Usage

Run command:

```terraform
terraform init
```

And this should create a:
- `.terraform` folder containing providers files to run the terraform code.
- `.terraform.lock.hcl` file containing versioning information about the providers installed.

After that you can run these commands:

```terraform
terraform plan -out apply.tfplan
terraform apply apply.tfplan
```

And you should see a new text file created.