# deploy keypair to all regions

module "keypair-us-west-1" {
  source       = "../modules/keypairs"
  region       = "us-west-1"
  netname      = "${local.netname}"
}
module "keypair-us-west-2" {
  source       = "../modules/keypairs"
  region       = "us-west-2"
  netname      = "${local.netname}"
}
module "keypair-us-east-1" {
  source       = "../modules/keypairs"
  region       = "us-east-1"
  netname      = "${local.netname}"
}
module "keypair-us-east-2" {
  source       = "../modules/keypairs"
  region       = "us-east-2"
  netname      = "${local.netname}"
}
module "keypair-ap-south-1" {
  source       = "../modules/keypairs"
  region       = "ap-south-1"
  netname      = "${local.netname}"
}
module "keypair-eu-west-1" {
  source       = "../modules/keypairs"
  region       = "eu-west-1"
  netname      = "${local.netname}"

}
module "keypair-sa-east-1" {
  source       = "../modules/keypairs"
  region       = "sa-east-1"
  netname      = "${local.netname}"
}