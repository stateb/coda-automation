module "testnet-pyramid-scheme" {
  source = "../modules/coda-testnet"
  net_name = "pyramid-scheme"
  net_region = "us-west-2"
  coda_version = "196448-release-0.0.3-beta-f027ad0c-PV96140f2c"
  seed_count = 1
  snarker_count = 1
  proposer_count = 5
}
