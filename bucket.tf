data "aws_canonical_user_id" "current" {}

module "s3_one" {
  source  = "terraform-aws-modules/s3-bucket/aws"

  bucket        = "cloudfront-${var.project}-${var.environment}"
  force_destroy = true

  tags = {
    "project"     = var.project,
    "environment" = var.environment
  }
}

module "log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"

  bucket = "cloudfront-logs-${var.project}-${var.environment}"
  acl    = null
  grant = [
    {
      type        = "CanonicalUser"
      permission  = "FULL_CONTROL"
      id          = data.aws_canonical_user_id.current.id
    },
    {
      type        = "CanonicalUser"
      permission  = "FULL_CONTROL"
      id          = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
    }
  ]
  force_destroy = true

  tags = {
    "project"     = var.project,
    "environment" = var.environment
  }
}