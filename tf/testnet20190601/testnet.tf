locals {
  netname    = "testnet20190601"                                                                                                                                                                                                                                                                                                                                                                                      # see also backend key
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIXZlEz8O1pPZXlbBoeHscQCWl6twmXarVyJnF7Ye+4bQOJS1Q/9EHKGDf2O80RqMAMxSAgDvg4DeVpEHuhKxqkpKEh7dxKu9xI0GMAESnxxaHsVpGYnT7Hb/EXn6aMFUXlttiNP/WeUmk0jbvdRWsRKXbK0RjVuatIqeoILXLmCAZ4ybaxz8423C7aSYEblpjbQ4mUJyt2cjUyNgD1LcZxFkiyyqUM39ymrYg2aMgblnVO5DMdHFN2zrKL+sW7WkyiSLbSzpRSBJMj/PP6e3zpmsK/GCnJ5TTBmoOaeD1/n45Ioz0+l9SBPOLVDJJ5WLywBmjwD1NCDbZS2RmApIczqG2HHmsAG9F6hcnEwdlKbctOA1i0Pxc3ohkdrwjltthntbJfUAIRLdecRTWKwJRcXW3RB/vAjB/d+VSrUdk9CpvlnvU82DwghzPgcBO2+9YI1riXT4DxOHd25hRjR5+DdgY7nI+nNjjd/XjgQJ3iTKpNrxKLH0rtGzq5jhjzJIBIeq92SH6OV3ySDBP+btCwzjNQHin/4qq8NOHFblw81eMtlRNon5AxA7q//xD6pClwGzfDirUGrUSnkeQ2/SMxLYll5VXGmhuWMDF9k6rMc+mILZdMhNgRdfqyPTzZ4f1pf+qI6lwWvyzY+DVn0HbGAOWOyTwd7uqhrBV2mWjyQ== conner@o1labs.com"
}

terraform {
  backend "s3" {
    key     = "test-net/terraform.tfstate"
    encrypt = true
    region  = "us-west-2"
    bucket  = "o1labs-terraform-state"
    acl     = "bucket-owner-full-control"
  }
}

provider "aws" {
  region = "us-west-2"
}

######################################################################
# instances

## Seeds
module "us-west-2-seed" {
  source        = "../modules/coda-node"
  region        = "us-west-2"
  server_count  = 1
  instance_type = "c5.xlarge"
  netname       = "${local.netname}"
  rolename      = "seed"
  public_key    = "${local.public_key}"
}

## Snarkers
module "us-west-2-snarker" {
  source        = "../modules/coda-node"
  region        = "us-west-2"
  server_count  = 3
  instance_type = "c5.4xlarge"
  netname       = "${local.netname}"
  rolename      = "snarker"
  public_key    = "${local.public_key}"
}

######################################################################
## Proposers

module "us-west-1-proposer" {
  source        = "../modules/coda-node"
  region        = "us-west-1"
  server_count  = 5
  instance_type = "c5.2xlarge"
  netname       = "${local.netname}"
  rolename      = "proposer"
  public_key    = "${local.public_key}"
}

module "us-west-2-proposer" {
  source        = "../modules/coda-node"
  region        = "us-west-2"
  server_count  = 5
  instance_type = "c5.2xlarge"
  netname       = "${local.netname}"
  rolename      = "proposer"
  public_key    = "${local.public_key}"
}

# module "us-east-1-proposer" {
#   source        = "../modules/coda-node"
#   region        = "us-east-1"
#   server_count  = 1
#   instance_type = "c5.2xlarge"
#   netname       = "${local.netname}"
#   rolename      = "proposer"
#   public_key    = "${local.public_key}"
# }
# module "eu-west-1-proposer" {
#   source        = "../modules/coda-node"
#   region        = "eu-west-1"
#   server_count  = 1
#   instance_type = "c5.2xlarge"
#   netname       = "${local.netname}"
#   rolename      = "proposer"
#   public_key    = "${local.public_key}"
# }

# module "sa-east-1-proposer" {
#   source        = "../modules/coda-node"
#   region        = "sa-east-1"
#   server_count  = 1
#   instance_type = "c5.2xlarge"
#   netname       = "${local.netname}"
#   rolename      = "proposer"
#   public_key    = "${local.public_key}"
# }

# module "ap-south-1-proposer" {
#   source        = "../modules/coda-node"
#   region        = "ap-south-1"
#   server_count  = 1
#   instance_type = "c5.2xlarge"
#   netname       = "${local.netname}"
#   rolename      = "proposer"
#   public_key    = "${local.public_key}"
# }
