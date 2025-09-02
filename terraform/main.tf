provider "aws" {
#  region = "${env.AWS_REGION}"
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "s3-bucket-tfstate-test"
    key    = "terraform.tfstate"
    region = "ap-southeast-1" 
    encrypt = true
  }
}
