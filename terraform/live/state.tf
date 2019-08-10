terraform {
  required_version = "~> 0.12.0"
  backend "s3" {
    key     = "test-net/running-testnets.tfstate"
    encrypt = true
    region  = "us-west-2"
    bucket  = "o1labs-terraform-state"
    acl     = "bucket-owner-full-control"
  }
}
