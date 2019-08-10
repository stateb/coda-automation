variable "net_name" {
    description = "The friendly name used to refer to the network."
    type = "string"
}

variable "net_region" {
    description = "The region to launch the testnet in."
    type = "string"
    default = "us-west-2"
}

variable "r53_dns_zone" {
  description = "The Route53 Zone to create DNS records under."
  type = "string"
  default = "o1test.net."
}


variable "coda_version" {
    description = "The version of coda to install on each node."
    type = "string"
}

variable "aws_key_name" {
    description = "The SSH Key that is to be installed on each EC2 instance."
    default = "testnet"
    type = "string"
}

variable "seed_count" {
  description = "Number of SNARK-workers to deploy."
  default = 1
}

variable "seed_instance_type" {
  description = "The EC2 Instance Type to use for Seed Nodes."
  default = "c5.xlarge"
  type = "string"
}


variable "snarker_count" {
  description = "Number of SNARK-workers to deploy."
  default = 1
}

variable "snarker_instance_type" {
  description = "The EC2 Instance Type to use for Snark Worker Nodes."
  default = "c5.4xlarge"
  type = "string"
}


variable "proposer_count" {
  description = "Number of SNARK-workers to deploy."
  default = 5
}

variable "proposer_instance_type" {
  description = "The EC2 Instance Type to use for Proposer Nodes."
  default = "c5.2xlarge"
  type = "string"
}

variable "joiner_count" {
  description = "Number of SNARK-workers to deploy."
  default = 0
}

variable "joiner_instance_type" {
  description = "The EC2 Instance Type to use for Joiner Nodes."
  default = "c5.xlarge"
  type = "string"
}
