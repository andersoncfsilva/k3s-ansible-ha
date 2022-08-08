variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCco5YXW7CDJQFlB8JDx4eqNYw5H9aDEP+5kX07D69nx2s3TMZbPXuwJqNswAnA5BDCmU4k/aNgyAgtR1N1WaQBNlqQFJslOfHkLZ7haZ7QCPWLG0Hg5I+zFhN8yxmfZwsbjMe0mvDtzX2jWwwZDMKwpnnsyQm3Q7neh6yEA0XmXRAW395EpOOLECX5U4UOU/DxENJJsV/McwvbSa1ZrRHbpYhz+Hvjpln5xXQ5+xbrBubQRMlfTRdf3sDYqnaDVgemWxfOk8y3GSU9xFuOPeSQECD/v9MI9MY1g2vQOCU+7uw1LKE0lqML7SYenYwg0TGlqG9QxIG8Q4bcP/DcUUsptGKWZ9jAhHDgQ6+RO1T+O0sEQV5xi/pJHnubtoesLgV3c+tmOsDiAH7zDVthId6NmWZEN0MeyFe6sL7fGIZrc4T9/TkSqsZtz6p7/+IIhiioJW1/y1dwdaj1rcasPBXbkB8k5qnnF+nP1fbVUmN9IDVbVxJkUh1qKnY4gTFXZKU= spider@workstation"
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