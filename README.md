![Coda Logo](https://cdn.codaprotocol.com/v4/static/img/coda-logo.png)

# Repository Purpose 
This repository is designed to show an opinionated example on how to operate a network of Coda Daemons. It implements the entire node lifecycle using a modern Infrastructure as Code toolset. Community contributions are warmly encouraged, please see the [contribution guidelines](#to-do) for more details. The code is designed to be as modular as possible, allowing the end-user to "pick and choose" the parts they would like to incorporate into their own infrastructure stack. 

# Code Structure
```
coda-automation
├── ansible
│   ├── tasks
│   └── testkeys
├── scripts
└── terraform
    ├── modules
    │   ├── coda-node
    │   └── elasticsearch
    └── testnets
        ├── testnet20190601
        └── testnet20190613
```

**Terraform:** Contains resource modules and live code to deploy a Coda Testnet. 
- Note: Currently **ALL** modules only support AWS, multi-cloud support is on the roadmap.
- *coda-node:* A Terraform module that encapsulates a single node.
- *elasticsearch:* A Terraform module that deploys an elasticsearch cluster using the AWS Elasticsearch service. 
*Ansible:* Contains runbooks that are designed to configure and run a set of Coda Daemons.
*Scripts:* Scripts that are designed to be placed on a remote node and executed locally. 

# Getting Started 
There's several steps involved in setting up your test net. 

## Prerequisites
For the purposes of this README we are assuming the following: 
- You have a configured AWS Account with credentials on your machine
- You have Terraform `0.12.x` installed on your machine
- You have Ansible `2.8.x` installed on your machine

## Clone the Repository
`git clone https://github.com/CodaProtocol/coda-automation.git`

## Create a new Testnet Terraform configuration
Note: You can totally use one of the existing configurations, but we'll assume you want to set one up from scratch
``` bash
$ cd coda-automation/terraform/testnets
$ mkdir testnet$(date +"%Y%m%d")
$ touch testnet$(date +"%Y%m%d")/testnet.tf
```

## Populate it with your node configuration and (optionally) other infrastructure
**Bare-Minimum testnet.tf:**
```
locals {
  netname    = "20190601"                                                                                                                                                                                                                                                                                                                                                                                      # see also backend key
  public_key = "< INSERT SSH KEY HERE> "
}

terraform {
  required_version = "~> 0.12.0"
  backend "s3" {
    key     = "test-net/terraform-20190601.tfstate"
    encrypt = true
    region  = "us-west-2"
    bucket  = "o1labs-terraform-state"
    acl     = "bucket-owner-full-control"
  }
}

provider "aws" {
  region = "us-west-2"
}

## One Seed
module "us-west-2-seed" {
  source        = "../../modules/coda-node"
  region        = "us-west-2"
  server_count  = 1
  instance_type = "c5.xlarge"
  netname       = "${local.netname}"
  rolename      = "seed"
  public_key    = "${local.public_key}"
}

## One Snarker
module "us-west-2-snarker" {
  source        = "../../modules/coda-node"
  region        = "us-west-2"
  server_count  = 1
  instance_type = "c5.4xlarge"
  netname       = "${local.netname}"
  rolename      = "snarker"
  public_key    = "${local.public_key}"
}

# Three Proposers
module "us-west-2-proposer" {
  source        = "../../modules/coda-node"
  region        = "us-west-2"
  server_count  = 3
  instance_type = "c5.2xlarge"
  netname       = "${local.netname}"
  rolename      = "proposer"
  public_key    = "${local.public_key}"
}
```

If you were to `terraform apply` this, you would get 4 instances, all in AWS's `us-west-2` region. However there is no Coda daemon installed! 

## Run Ansible against your Coda Testnet
Next, we need to install the coda daemon.
- Note: currently, the `coda-init.yaml` runbook installs elastic beats for log collection, more flexible runbooks are on the roadmap. 
- Note: currently the `coda-init.yaml` runbook installs SSH Keys for the core Coda team to debug nodes. You should modify `ansible/tasks/task-sshkeys.yaml` to reflect your github username.
- Note: see `ansible/tasks` for a details list of installation steps.  
```
$ cd coda-automation/ansible
$ ansible-playbook -i ec2.py -u admin -e netname=$(date +"%Y%m%d") coda-init.yaml
```

The `coda-init.yaml` runbook will SSH to all the machines in your testnet, installing Coda, configuring the Daemons, and installing log collectors. 

Lastly, you must run the `coda-start.yaml` runbook to start the Daemons in the correct order. 

```
$ ansible-playbook -i ec2.py -u admin -e netname=$(date +"%Y%m%d") coda-start.yaml
```

This step will start the seed node, then join any Snarkers to the network before joining any Proposers. 