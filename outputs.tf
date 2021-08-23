output "bucket_name" {
  description = "The name of the bucket."
  value       = element(concat(aws_s3_bucket.this.*.id, [""]), 0)
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::<bucket_name>."
  value       = element(concat(aws_s3_bucket.this.*.arn, [""]), 0)
}