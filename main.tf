provider "aws" {
  region = var.region
}

# Loop through the list of bucket names and create each bucket using the module
module "s3_buckets" {
  source  = "clouddrove/s3/aws"
  for_each = toset(var.bucket_names)

  name       = each.value
  versioning = true
}

# Create S3 bucket policies for each bucket created by the module
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  for_each = module.s3_buckets

  bucket = each.value["id"]

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = ""
    Statement = [
      {
        Sid       = "Object Level Permission"
        Effect    = "Allow"
        Principal = {
          AWS = var.principal_arn
        }
        Action   = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete"
        ]
        Resource = "${each.value["arn"]}/*"
      },
      {
        Sid       = "Bucket Level Permission"
        Effect    = "Allow"
        Principal = {
          AWS = var.principal_arn
        }
        Action   = [
          "s3:List*",
          "s3:GetBucketVersioning",
          "s3:PutBucketVersioning"
        ]
        Resource = each.value["arn"]
      }
    ]
  })
}
