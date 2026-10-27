
terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "2026terraform-state-bucket-example"
    key          = "infrastructure/04/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }

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

resource "aws_instance" "dev" {
  ami = "ami-0c7632fb77f35db43"
  key_name = "asia-specific-mdev-pc"
  instance_type = "t3.micro"
  
  tags = {
    Name = "Dev_Server"
    Environment = "development"
  }
}
