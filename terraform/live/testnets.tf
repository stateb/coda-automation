module "testnet-medium-rare" {
  source = "../modules/coda-testnet"
  net_name = "medium-rare"
  net_region = "us-west-2"
  coda_version = "197072-release-0.0.3-beta-e564a9e5-PV0a4e5137"
  seed_count = 1
  snarker_count = 1
  proposer_count = 1
}


# module "testnet-pyramid-scheme-west-1" {
#   source = "../modules/coda-testnet"
#   net_name = "pyramid-scheme"
#   net_region = "us-west-1"
#   coda_version = "196647-release-0.0.3-beta-f8bb7ff4-PV09df200b"
#   seed_count = 1
#   seed_instance_type = "c5.2xlarge"
#   proposer_count = 5
#   proposer_instance_type = "c5.2xlarge"
# }