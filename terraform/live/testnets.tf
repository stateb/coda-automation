module "testnet-pyramid-scheme" {
  source = "../modules/coda-testnet"
  net_name = "pyramid-scheme"
  net_region = "us-west-2"
  coda_version = "195917-release-0.0.3-beta-e3b9aead-PV222430f0"
  seed_count = 1
  snarker_count = 1
  proposer_count = 5
}

