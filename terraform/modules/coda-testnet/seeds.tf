## Seeds
module "seed" {
  source        = "../coda-node"
  region        = "${var.net_region}"
  server_count  = "${var.seed_count}"
  instance_type = "${var.seed_instance_type}"
  netname       = "${var.net_name}"
  rolename      = "seed"
  key_name      = "${var.aws_key_name}"
  public_key    = ""
  coda_version  = "${var.coda_version}"
}