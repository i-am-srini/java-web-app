terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.30, < 4.0.0"
    }
  }
}

provider "aws" {
region = "us-west-2"
access_key = var.access-key
secret_key = var.secret-key
}

