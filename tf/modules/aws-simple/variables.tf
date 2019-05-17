variable "netname" {
  default = "NONETNAMESET"
}

variable "rolename" {
  default = "NOROLENAMESET"
}

variable "proposer_order" {
  default = "NONE"
}

variable "region" {
  default = "us-west-2"
}

variable "server_count" {
  default = 1
}

variable "instance_type" {
  default = "c5.large"
}

variable "key_pair_name" {
  default = "testnet"
}

variable "use_eip" {
  description = "If true, apply EIP"
  default     = false
}
variable "seed_eip" {
  description = "If true, apply EIP"
  default     = false
}
variable "security_group" {
  default = ""
}

variable "iam_instance_profile" {
  default = ""
}