locals {
  netname     = "testnet20190517"  # see also backend key
  port_rpc    = 8301
  port_gossip = 9302
  port_dht    = 9303
  port_ql     = 9375
}

terraform {
  required_version = "~> 0.11"
  backend "s3" {
    key                  = "testnet20190517/terraform.tfstate"
    encrypt              = true
    region               = "us-west-2"
    bucket               = "o1labs-terraform-state"
    acl                  = "bucket-owner-full-control"
  }
}

provider "aws" {
  region  = "us-west-2"
  version = "~> 1.41"
}

######################################################################
# instances

## Seeds
module "us-west-2-seed" {
  source         = "../modules/aws-simple"
  region         = "us-west-2"
  server_count   = "1"
  instance_type  = "c5.xlarge"
  security_group = "${module.sg_us-west-2.security_group}"
  netname        = "${local.netname}"
  rolename       = "seed"
}

## Snarkers
module "us-west-2-snarker" {
  source         = "../modules/aws-simple"
  region         = "us-west-2"
  server_count   = "1"
  instance_type  = "c5.4xlarge"
  security_group = "${module.sg_us-west-2.security_group}"
  netname        = "${local.netname}"
  rolename       = "snarker"
}

## Joiner
module "us-west-2-joiner" {
  source         = "../modules/aws-simple"
  region         = "us-west-2"
  server_count   = "0"
  instance_type  = "c5.xlarge"
  security_group = "${module.sg_us-west-2.security_group}"
  netname        = "${local.netname}"
  rolename       = "joiner"
}

######################################################################
## Proposers

module "us-west-1-proposer" { # California
  source         = "../modules/aws-simple"
  region         = "us-west-1"
  server_count   = "1"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_us-west-1.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
module "us-west-2-proposer" {  # Oregon
  source         = "../modules/aws-simple"
  region         = "us-west-2"
  server_count   = "2"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_us-west-2.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
module "us-east-1-proposer" { # Virginia
  source         = "../modules/aws-simple"
  region         = "us-east-1"
  server_count   = "1"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_us-east-1.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
module "us-east-2-proposer" { # Ohio
  source         = "../modules/aws-simple"
  region         = "us-east-2"
  server_count   = "1"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_us-east-2.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
module "eu-west-1-proposer" { # Ireland
  source         = "../modules/aws-simple"
  region         = "eu-west-1"
  server_count   = "0"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_eu-west-1.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
module "sa-east-1-proposer" { # Sao Paulo
  source         = "../modules/aws-simple"
  region         = "sa-east-1"
  server_count   = "0"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_sa-east-1.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
module "ap-south-1-proposer" { # Mumbai
  source         = "../modules/aws-simple"
  region         = "ap-south-1"
  server_count   = "0"
  instance_type  = "c5.2xlarge"
  security_group = "${module.sg_ap-south-1.security_group}"
  netname        = "${local.netname}"
  rolename       = "proposer"
}
