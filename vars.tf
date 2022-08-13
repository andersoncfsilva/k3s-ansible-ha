variable "ssh_key" {
  default = "CHANGEME!!!" 
}

variable "proxmox_host" {
    default = "pve"
}

variable "template_name" {
    default = "ubuntu-2004-cloudinit-template"
}

variable "ansible_user" {
    default = "ubuntu"
}