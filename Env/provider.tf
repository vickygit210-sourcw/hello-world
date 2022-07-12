terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.6.0"
    }
  }
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  shared_credentials_file = "~/.aws/config"
}
