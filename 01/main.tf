terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.6"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "app_server" {
  ami = "ami-0c7632fb77f35db43"
  key_name = "asia-specific-mdev-pc"
  instance_type = "t3.small"
  count = 2

  tags = {
    Name = "Dev_Server"
    Environment = "development"
  }
}