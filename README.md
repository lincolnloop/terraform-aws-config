# Terraform AWS CloudWatch Alerts

This module configures AWS Config.
## Usage

```hcl
module "aws_config" {
  source                       = "github.com/lincolnloop/terraform-aws-config"
  s3_bucket_name               = "aws-config-bucket"
  tags                         = var.tags
  sns_topic_arn                = "arn:aws:sns:::"
  prefix                       = "aws-config"
  iam_role_services            = ["config.amazonaws.com"]
  iam_role_name                = "AWSConfigRole"
  iam_role_path                = "/service-role/"
  iam_managed_policy_arns      = ["arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"]
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| s3_bucket_name | Name for the AWS Config bucket | `string` | no | yes |
| s3_version_expiration | Days to expire S3 versions for AWS Config bucket | `string` | 365 | no |
| snapshot_delivery_frequency | Snapshot frequency for AWS Config | `string` | `Three_Hours` | no |
| sns_topic_arn | SNS topic to send notificatios from AWS Config.(Optional) | `string` | null | no |
| tags | Configuration for resources tags. | `object` | Review next section for default value | no |
| prefix | Naming prefix to use for resources. | `string` | `aws-config` | no |
| iam_role_services | Services authorized to use the IAM Role. | `list(string)` | `["config.amazonaws.com"]` | no |
| iam_role_name | Name for the IAM Role for AWS Config configuration. | `string` | `AWSConfigRole` | no |
| iam_role_path | Path for IAM creation. | `string` | `/service-role/` | no |
| iam_managed_policy_arns | List of ARN of the managed policies to add permissions to the IAM Role. | `list(string)` | `["arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"]` | no |

### Variable `tags`

This input variable controls the tags that will be added to all the resources.
```
  tags = {
    Application = "aws-config"
  }
```

Default value is shown here

## Requirements

- Terraform 1.4 or newer
- AWS Provider 4.67 or newer