variable "region" {
  description = "The AWS region"
  type        = string
}

variable "bucket_names" {
  description = "The list of S3 bucket names"
  type        = list(string)
}

variable "principal_arn" {
  description = "The ARN of the principal (IAM role) for bucket replication"
  type        = string
}
