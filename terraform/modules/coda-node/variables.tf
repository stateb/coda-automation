variable "instance_type" {
  description = "Type of instance to launch Coda on"
  type        = string
  default     = "c5.large"
}

variable "netname" {
  description = "Name of the testnet, used for tagging resources"
  type        = string
  default     = "NONETNAMESET"
}

variable "port_rpc" {
  description = "Port RPC protocol communicates over"
  type        = number
  default     = 8301
}

variable "port_gossip" {
  description = "Port Gossip protocol communicates over"
  type        = number
  default     = 8302
}

variable "port_dht" {
  description = "Port DHT protocol communicates over"
  type        = number
  default     = 8303
}

variable "port_ql" {
  description = "Port GraphQL endpoint is listening on"
  type        = number
  default     = 8304
}

variable "public_key" {
  description = "An SSH Public Key used to configure node access, if not set defaults to key_name"
  type        = "string"
  default     = ""
}

variable "key_name" {
  description = "The name of an AWS Public Key"
  type        = "string"
}

variable "region" {
  description = "The region the module should be deployed to"
  type        = string
  default     = "us-west-2"
}

#Options: "seed", "snarker",  "joiner", "proposer"
variable "rolename" {
  description = "The role the node should assume when it starts up, also used for resource tagging"
  type        = string
}

variable "server_count" {
  description = "Number of Coda nodes to launch"
  type        = number
  default     = 1
}

variable "use_eip" {
  description = "If true, apply EIP"
  default     = true
}
