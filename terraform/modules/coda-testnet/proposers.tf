module "proposer" {
  source        = "../coda-node"
  region        = "${var.net_region}"
  server_count  = "${var.proposer_count}"
  instance_type = "${var.proposer_instance_type}"
  netname       = "${var.net_name}"
  rolename      = "proposer"
  key_name      = "${var.aws_key_name}"
  public_key    = ""
  coda_version  = "${var.coda_version}"
}