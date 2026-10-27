
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.70.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name

  # Prevent accidental deletion through Terraform.
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "terraform-remote-state"
    Environment = "learning"
  }
}

# Keep previous state versions for recovery.
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access to the state bucket.
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
