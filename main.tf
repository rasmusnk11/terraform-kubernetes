provider "vsphere" {
  user                 = 
  password             = 
  vsphere_server       = 
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "LAB-SILK"
}

data "vsphere_datastore" "datastore" {
  name          = "System"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "LAB-SILK"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "Kubernetes (Vlan 110)"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-temp-22.04.2"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "silk-kube-master01"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus         = 2
  memory           = 2048
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "silk-kube-master01"
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "silk-kube-master01"
        domain    = "example.com"
      }
      network_interface {
        ipv4_address = "10.200.110.100"
        ipv4_netmask = 24
      }
      ipv4_gateway = "10.200.110.1"
    }
  }
}
