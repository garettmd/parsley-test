provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.1.8"

  # For some reason, TF isn't able to find this bucket created with awslocal, and while running tflocal. But this is how the configuration should work.
  backend "s3" {
    bucket = "parsley-tf-state"
    key    = "test"
    region = "us-east-1"
  }
}

