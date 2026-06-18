provider "aws" {
  region = "eu-central-1"
} 

terraform {
  backend "s3" {
    bucket         = "tf-resources-gha9"
    region         = "us-east-1"
    key            = "github-actions/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "if-reources-gha-lock9"
  }
}