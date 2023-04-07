provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacente
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastorer
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_hostname
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus         = 2
  memory           = 2048
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = var.vm_hostname
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = var.vm_hostname
        domain    = "example.com"
      }
      network_interface {
        ipv4_address = var.vm_ipaddress
        ipv4_netmask = 24
      }
      ipv4_gateway = var.vm_gateway
    }
  }
}
