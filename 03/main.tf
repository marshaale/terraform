
terraform {
  required_version = ">= 1.5.0"

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

resource "aws_vpc" "health_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "health-vpc"
    Environment = "learning"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.health_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "health-public-subnet"
    Environment = "learning"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.health_vpc.id

  tags = {
    Name = "health-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.health_vpc.id

  tags = {
    Name = "health-public-route-table"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}