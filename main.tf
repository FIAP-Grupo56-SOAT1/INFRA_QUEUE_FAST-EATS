terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }

  backend "s3" {
    bucket = "bucket-fiap56-to-remote-state"
    key    = "aws-infra-sqs-fiap56/terraform.tfstate"
    region = "us-east-1"
  }
}



provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner      = var.owner
      managed-by = var.managedby
    }
  }
}