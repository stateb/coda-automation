# IAM roles are global
module "iam-us-west-2" {
  source       = "../modules/iam_role"
  netname     = "${local.netname}"
}