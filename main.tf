
data "vsphere_datacenter" "target_dc" {
  name                            = var.deploy_vsphere_datacenter
}

data "vsphere_datastore" "target_datastore" {
  name                            = var.deploy_vsphere_datastore
  datacenter_id                   = data.vsphere_datacenter.target_dc.id
}

data "vsphere_compute_cluster" "target_cluster" {
  name                            = var.deploy_vsphere_cluster
  datacenter_id                   = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "public_v352" {
  name                            = var.deploy_vsphere_network_v352
  datacenter_id                   = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "private_v2476" {
  name                            = var.deploy_vsphere_network_v2476
  datacenter_id                   = data.vsphere_datacenter.target_dc.id
}

data "vsphere_virtual_machine" "source_template" {
  name                            = var.node_template
  datacenter_id                   = data.vsphere_datacenter.target_dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name                            = var.node_host_name 
  wait_for_guest_net_timeout      = var.wait_for_guest_net_timeout
  resource_pool_id                = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  datastore_id                    = data.vsphere_datastore.target_datastore.id
  tags                            = var.tags
  folder                          = var.folder
  num_cpus                        = var.node_vcpus
  memory                          = var.node_memory
  guest_id                        = data.vsphere_virtual_machine.source_template.guest_id

  scsi_type                       = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id                    = data.vsphere_network.public_v352.id
    adapter_type                  = "e1000"
  }

  network_interface {
    network_id                    = data.vsphere_network.private_v2476.id
    adapter_type                  = "e1000"
  }

  disk {
    label                         = "disk0"
    size                          = var.node_disk_size
    datastore_id                  = data.vsphere_datastore.target_datastore.id
    unit_number                   = 0
  }

  clone {
    template_uuid                 = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name                 = var.node_host_name
        domain                    = var.node_domain
      }

      network_interface {
        ipv4_address              = var.node_public_ip
        ipv4_netmask              = var.node_public_ip_netmask 
      }

      network_interface {}

      dns_server_list             = var.node_dns_servers
      dns_suffix_list             = var.node_dns_suffix

      ipv4_gateway                = var.node_public_ip_gateway
    }
  }
}


output "vsphere_vm_hostname" {
  value                           = vsphere_virtual_machine.vm.name
}

output "vsphere_vm_default_ip_confluence" {
  value                           = vsphere_virtual_machine.vm.default_ip_address
}

output "vsphere_vm_guest_ips_confluence" {
  value                           = vsphere_virtual_machine.vm.guest_ip_addresses
}
