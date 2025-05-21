terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "my-terraform-state-bucket-410293310337" # Replace with your actual S3 bucket name
    key            = "global/ec2/terraform.tfstate"           # Path within the bucket for your state file (choose a logical path)
    region         = "eu-central-1"                           # Replace with the region of your S3 bucket
    dynamodb_table = "my-terraform-state-lock-table"          # Replace with your DynamoDB table name
    encrypt        = true                                     # Recommended: Use S3 server-side encryption
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "default"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ecf75a98fe8519d7"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

