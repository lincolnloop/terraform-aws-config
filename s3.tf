##########################################
#  S3 Resources                          #
##########################################

resource "aws_s3_bucket" "config" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "config" {
  bucket = aws_s3_bucket.config.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "config" {
  bucket = aws_s3_bucket.config.id
  rule {
    id     = "Delete previous after {$var.s3_version_expiration} days"
    status = "Enabled"
    noncurrent_version_expiration {
      noncurrent_days = var.s3_version_expiration
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "config" {
  bucket = aws_s3_bucket.config.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "config" {
  bucket                  = aws_s3_bucket.config.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "config" {
  bucket = aws_s3_bucket.config.bucket
  policy = data.aws_iam_policy_document.config_bucket_policy.json
}