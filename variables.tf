variable "deploy_vsphere_datacenter" {}
variable "deploy_vsphere_cluster" {}
variable "deploy_vsphere_datastore" {}


variable "deploy_vsphere_network_v352" {
  type        = string
  default     = "dvPG-vlan352"
}

variable "deploy_vsphere_network_v2476" {
  type        = string
  default     = "dvPG-vlan2476"
}

variable "node_host_name" {}

variable "node_wait_for_guest_net_timeout" {
  type        = number
  default     = 0
}

variable "node_template" {
  type        = string
  default     = "ucsb-lib-template-packer-core-linux-centos-7"
}

variable "node_vcpus" {
  description = "The number of virtual processors to assign to this virtual machine. Default: 1."
  default     = "1"
}

variable "node_memory" {
  default     = "1024"
}

variable "node_dns_servers" {
  type        = list
  default     = [
    "10.3.112.36",
    "10.3.112.16"
  ]
}

variable "node_dns_suffix" {
  type        = list
  default     = [
    "library.ucsb.edu"
  ]
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
}

variable "node_domain" {
  type        = string
  description = "The domain name for this machine."
  default     = "library.ucsb.edu"
}

variable "node_disk_size" {
  description = "Size of the node root disk represented in GBs"
  default     = "30"
}

variable "node_public_ip" {
  description = "The ipv4 public host address"
}

variable "node_public_ip_netmask" {
  description = "The ipv4 public address CIDR"
  default     = 24
}

variable "node_public_ip_gateway" {
  description = "The ipv4 gateway used by the public ip"
  default     = "128.111.87.254"
}

variable "wait_for_guest_net_timeout" {
  type        = number
  default     = 0
}

variable "tags" {
  type        = list
  default     = []
}

variable "folder" {
  type        = string
}
