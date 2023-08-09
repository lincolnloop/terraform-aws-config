##########################################
#  Data configurations for the module    #
##########################################
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "config" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "config_bucket_policy" {
  statement {
    sid = "AWSConfigBucketPermissionsCheck"
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.config.arn]
  }
  statement {
    sid = "AWSConfigBucketDelivery"
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.config.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
  statement {
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    effect    = "Deny"
    actions   = ["*"]
    resources = ["${aws_s3_bucket.config.arn}/*"]
    condition {
      test     = "Bool"
      values   = [false]
      variable = "aws:SecureTransport"
    }
  }
}

##########################################
#  Config Resources                      #
##########################################

resource "aws_config_configuration_recorder" "config" {
  name     = "${var.prefix}-default"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "config" {
  name           = "${var.prefix}-default"
  depends_on     = [aws_config_configuration_recorder.config]
  s3_bucket_name = aws_s3_bucket.config.bucket
  sns_topic_arn  = var.sns_topic_arn != null ? var.sns_topic_arn : null

  snapshot_delivery_properties {
    delivery_frequency = var.snapshot_delivery_frequency
  }
}

resource "aws_config_configuration_recorder_status" "config" {
  name       = aws_config_configuration_recorder.config.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.config]
}