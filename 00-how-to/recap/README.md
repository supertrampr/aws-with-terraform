# First project

This folder contains a [Terraform](https://developer.hashicorp.com/terraform) configuration that shows a recap of what a basic configuration is for a project.

## Requirements

- [terraform](https://developer.hashicorp.com/terraform/install) >= 1.13.0;

## Usage

Prior to initalizing your project, please be sure to:
- create an [S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html) on your [AWS account](https://aws.amazon.com/account/).
- copy the content of [sample.hcl](backend/sample.hcl) file to another file (e.g.: backend/aws.hcl)
- fill the fields needed

Then run command:

```terraform
terraform init -backend-config backend/aws.hcl
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