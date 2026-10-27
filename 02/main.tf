terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.70.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "dev2026-terraform-example-bucket"

  tags = {
    Name = "dev_2026_terraform_example_bucket"
    Environment = "development"
  }
}