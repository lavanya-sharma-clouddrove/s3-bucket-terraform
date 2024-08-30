output "s3_bucket_arns" {
  description = "The ARNs of the created S3 buckets"
  value       = [for module in module.s3_buckets : module["arn"]]
}

output "s3_bucket_ids" {
  description = "The IDs of the created S3 buckets"
  value       = [for module in module.s3_buckets : module["id"]]
}
