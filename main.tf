terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "demo-bucket"{
  bucket = "olu-demo-bucket"

  tags = {
    Name = "S3Bucket"
  }
}
#A resource to enable versioning on bucket
resource "aws_s3_bucket_versioning" "versioning_demo" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
#Block Public Access
resource "aws_s3_bucket_public_access_block" "demo_public_block" {
  bucket = aws_s3_bucket.demo-bucket.bucket

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}