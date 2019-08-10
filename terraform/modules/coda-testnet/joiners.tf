module "joiner" {
  source        = "../coda-node"
  region        = "${var.net_region}"
  server_count  = "${var.joiner_count}"
  instance_type = "${var.joiner_instance_type}"
  netname       = "${var.net_name}"
  rolename      = "joiner"
  key_name      = "${var.aws_key_name}"
  public_key    = ""
  coda_version  = "${var.coda_version}"
}