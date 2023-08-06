variable "snapshot_delivery_frequency" {
  type = string
  description = "Delivery frequency for AWS Config"
  default = "Three_Hours"
  
}

variable "tags" {
  description = "Tags configuration for Cloudwatch"
  type        = map(string)
  default     = {
    Application = "aws-config"
  }
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket name"
}

variable "s3_version_expiration" {
  type = string
  description = "Days to expirate the aws config logs on the S3 buckets"
  default = "365"
}

variable "sns_topic_arn" {
  type        = string
  description = "SNS Topic to send notifications too (Optional)"
  default     = null
}

variable "prefix" {
  type = string
  description = "Prefix to use for naming resources"
  default = "aws-config"
}

#IAM 

variable "iam_role_services" {
  type = list(string)
  default = ["config.amazonaws.com"]
}
variable "iam_role_name" {
  type = string
  default = "AWSConfigRole"
}

variable "iam_role_path" {
  type    = string
  default = "/service-role/"
}

variable "iam_managed_policy_arns" {
  type    = list(string)
  default = ["arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"]
}