provider "aws" {
  region     = "ap-southeast-1"
  access_key = "AKIA27VE4QSF4MPE2X77"
  secret_key = "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"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  required_version = ">= 1.0.0"
}