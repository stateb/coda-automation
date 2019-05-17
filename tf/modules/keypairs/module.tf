variable "region" {
  default = "us-west-2"
}
terraform {
  required_version = "~> 0.11"
}
provider "aws" {
  region = "${var.region}"
}
resource "aws_key_pair" "testnet" {
  key_name   = "${var.netname}"
  public_key = "${var.public_key}"
}
