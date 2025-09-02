provider "aws" {
#  region = "${env.AWS_REGION}"
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "s3s3-bucket-tfstate-test"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform State"
  }
}

terraform {
  backend "s3" {
    bucket = "s3-bucket-tfstate-test"
    key    = "terraform.tfstate"
    region = "ap-southeast-1" 
    encrypt = true
  }
}
