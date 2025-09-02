provider "aws" {
#  region = "${env.AWS_REGION}"
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "s3-bucket-tfstate"
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
    bucket = aws_s3_bucket.terraform_state.bucket
    key    = "terraform.tfstate"
    region = "ap-southeast-1" 
    encrypt = true
  }
}
