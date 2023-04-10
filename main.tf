provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
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
  count            = length(var.master_ips)
  name             = "${var.vm_hostname}-master0${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus         = 2
  memory           = 2048
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "${var.vm_hostname}-master0${count.index + 1}"
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.vm_hostname}-master0${count.index + 1}"
        domain    = var.domain
      }
      network_interface {
        ipv4_address = lookup(var.master_ips, count.index)
        ipv4_netmask = var.ipv4_netmask
      }
      ipv4_gateway = var.vm_gateway
      dns_server_list = [var.dns_servers]
    }
  }
}

resource "null_resource" "authorized_keys" {
  count            = length(var.master_ips)
  connection {
    type     = "ssh"
    host     = lookup(var.master_ips, count.index)
    user     = var.admin_username
    password = var.admin_password
  }

  provisioner "file" {
    destination = "/home/rasmus/.ssh/authorized_keys"
    content     = var.ssh_keys
  }
}

resource "vsphere_virtual_machine" "vm" {
  count            = length(var.worker_ips)
  name             = "${var.vm_hostname}-worker0${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus         = 2
  memory           = 2048
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "${var.vm_hostname}-worker0${count.index + 1}"
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.vm_hostname}-worker0${count.index + 1}"
        domain    = var.domain
      }
      network_interface {
        ipv4_address = lookup(var.worker_ips, count.index)
        ipv4_netmask = var.ipv4_netmask
      }
      ipv4_gateway = var.vm_gateway
      dns_server_list = [var.dns_servers]
    }
  }
}

resource "null_resource" "authorized_keys" {
  count            = length(var.worker_ips)
  connection {
    type     = "ssh"
    host     = lookup(var.worker_ips, count.index)
    user     = var.admin_username
    password = var.admin_password
  }

  provisioner "file" {
    destination = "/home/rasmus/.ssh/authorized_keys"
    content     = var.ssh_keys
  }
}