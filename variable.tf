variable "vsphere_user" {
 description = "vsphere user"
}

variable "vsphere_password" {
 description = "vsphere_password"
}

variable "vsphere_server" {
 description = "vsphere server"
}

variable "vsphere_datacenter" {
 description = "vsphere datacenter"
}

variable "vsphere_datastore" {
 description = "vsphere datastote"
}

variable "vsphere_compute_cluster" {
 description = "vsphere cluster"
}

variable "vsphere_network" {
 description = "vsphere network"
}

variable "vsphere_template" {
 description = "VM template"
}

variable "vm_hostname" {
 description = "VM hostname wil be vm name in vspaher"
}

variable "vm_gateway" {
 description = "VM gateway"
}

variable "master_ips" {
  type        = map(any)
  description = "List of ips address"
}

variable "worker_ips" {
  type        = map(any)
  description = "List of ips address"
}

variable "ipv4_netmask" {
  description = "ipv4 netmask"
}

variable "dns_servers" {
  description = "dns server"
}

variable "domain" {
  description = "domainname"
}

variable "admin_username" {
  description = "admin username to template"
}

variable "admin_password" {
  description = "admin password to template"
}

variable "ssh_keys" {
  description = "ssh key"
}

variable "proxy_hostname" {
  description = "hostname of proxy"
}

variable "proxy_ips" {
  type        = map(any)
  description = "List of ips address"
}
