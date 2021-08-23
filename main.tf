resource "aws_s3_bucket" "this" {
  # Set the name of the bucket
  bucket = var.bucket_name

  # Specify the canned access-control list (ACL)
  acl = var.acl != "null" ? var.acl : null

  dynamic "logging" {
    # Check if the bucket server access logs should be recorded
    for_each = var.logging.target_bucket != null ? [var.logging] : []

    content {
      target_bucket = var.logging.target_bucket
      target_prefix = lookup(var.logging, "target_prefix", null)
    }
  }

  # Set the default configuration to use SSE-S3 (AES-256 bit) encryption at rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Set the bucket tags
  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  # Create a reference to the bucket
  bucket = aws_s3_bucket.this[0].id

  # Block all public access to the bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}