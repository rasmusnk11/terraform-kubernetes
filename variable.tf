variable "vsphere_user" {
 type = string
 default = ""
 description = "vsphere user"
}

variable "vsphere_password" {
 type = string
 default = ""
 description = "vsphere_password"
}

variable "vsphere_server" {
 type = string
 default = ""
 description = "vsphere server"
}

variable "vsphere_datacenter" {
 type = string
 default = ""
 description = "vsphere datacenter"
}

variable "vsphere_datastore" {
 type = string
 default = ""
 description = "vsphere datastote"
}

variable "vsphere_compute_cluster" {
 type = string
 default = ""
 description = "vsphere cluster"
}

variable "vsphere_network" {
 type = string
 default = ""
 description = "vsphere network"
}

variable "vsphere_template" {
 type = string
 default = ""
 description = "VM template"
}

variable "vm_hostname" {
 type = string
 default = ""
 description = "VM hostname wil be vm name in vspaher"
}

variable "vm_ipaddress" {
 type = init
 default = ""
 description = "VM ip address default er /24"
}

variable "vm_gateway" {
 type = init
 default = ""
 description = "VM gateway"
}