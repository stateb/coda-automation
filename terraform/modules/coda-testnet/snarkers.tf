module "snarker" {
  source        = "../coda-node"
  region        = "${var.net_region}"
  server_count  = "${var.snarker_count}"
  instance_type = "${var.snarker_instance_type}"
  netname       = "${var.net_name}"
  rolename      = "snarker"
  key_name      = "${var.aws_key_name}"
  public_key    = ""
  coda_version  = "${var.coda_version}"
}