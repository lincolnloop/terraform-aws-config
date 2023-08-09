# Terraform AWS CloudWatch Alerts

This module configures AWS Config.
## Usage

```hcl
module "aws_config" {
  source                       = "github.com/lincolnloop/terraform-aws-config"
  s3_bucket_name               = "aws-config-bucket"
  tags                         = { Application = "aws-config" }
  sns_topic_arn                = "arn:aws:sns:::"
  prefix                       = "aws-config"
  iam_role_name                = "AWSConfigRole"
  iam_role_path                = "/service-role/"
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| s3_bucket_name | Name for the AWS Config bucket | `string` | no | yes |
| s3_version_expiration | Days to expire S3 versions for AWS Config bucket | `string` | 365 | no |
| snapshot_delivery_frequency | Snapshot frequency for AWS Config | `string` | `Three_Hours` | no |
| sns_topic_arn | SNS topic to send notificatios from AWS Config.(Optional) | `string` | null | no |
| tags | Configuration for resources tags. | `object` | tags = { Application = "aws-config" } | no |
| prefix | Naming prefix to use for resources. | `string` | `aws-config` | no |
| iam_role_name | Name for the IAM Role for AWS Config configuration. | `string` | `AWSConfigRole` | no |
| iam_role_path | Path for IAM creation. | `string` | `/service-role/` | no |
## Requirements

- Terraform 1.4 or newer
- AWS Provider 4.67 or newer