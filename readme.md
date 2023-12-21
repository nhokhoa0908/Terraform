# Terraform
Use TF code to make infrastructure: 4 EC2: 2 on public-subnet-1; 2 on public-subnet-2

Create file variable.tf to declare variables: `aws_access_key`, `aws_secret_key`, `aws_region`, `aws_availability_zone`

```terraform init``` > Initialize working environment with terraform

```terraform plan``` > create an execution plan

```terraform apply``` > make changes
