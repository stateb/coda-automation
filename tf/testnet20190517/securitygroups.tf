######################################################################
# Security Groups

# WANT: Module for_each loops...
module "sg_us-west-1" {
  source      = "../modules/security_group"
  region      = "us-west-1"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}
module "sg_us-west-2" {
  source      = "../modules/security_group"
  region      = "us-west-2"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}
module "sg_us-east-1" {
  source      = "../modules/security_group"
  region      = "us-east-1"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}
module "sg_us-east-2" {
  source      = "../modules/security_group"
  region      = "us-east-2"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}
module "sg_eu-west-1" {
  source      = "../modules/security_group"
  region      = "eu-west-1"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}

module "sg_eu-north-1" {
  source      = "../modules/security_group"
  region      = "eu-north-1"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}

module "sg_sa-east-1" {
  source      = "../modules/security_group"
  region      = "sa-east-1"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}

module "sg_ap-south-1" {
  source      = "../modules/security_group"
  region      = "ap-south-1"
  port_rpc    = "${local.port_rpc}"
  port_gossip = "${local.port_gossip}"
  port_dht    = "${local.port_dht}"
  port_ql     = "${local.port_ql}"
  netname     = "${local.netname}"
}
