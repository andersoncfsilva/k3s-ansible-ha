
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.8"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.3.11:8006/api2/json"
  pm_api_token_id = "terraform-prov@pve!terraform-prov"
  pm_api_token_secret = "64c550f1-c0c8-4283-86ad-91e4564f4b85"
  pm_tls_insecure = true
}


resource "proxmox_vm_qemu" "kube-server" {
  count = 3
  name = "k3s-server-0${count.index + 1}"
  target_node = "pve"
  vmid = "40${count.index + 1}"

  clone = "ubuntu-2004-cloudinit-template"

  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "32G"
    type = "scsi"
    storage = "local-zfs"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.3.4${count.index + 1}/24,gw=192.168.3.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "kube-agent" {
  count = 3
  name = "k3s-agent-0${count.index + 1}"
  target_node = "pve"
  vmid = "50${count.index + 1}"

  clone = "ubuntu-2004-cloudinit-template"

  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "20G"
    type = "scsi"
    storage = "local-zfs"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.3.5${count.index + 1}/24,gw=192.168.3.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
