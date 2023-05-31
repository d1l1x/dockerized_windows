packer {
  required_plugins {
    virtualbox = {
      version = "~> 1.0.0"
      # version = "= 0.0.1"
      source = "github.com/hashicorp/virtualbox"
    }
  }
}

variable "user" {
  type = string
  default = "vagrant" 
}

variable "password" {
  type = string
  default = "vagrant" 
}


source "virtualbox-iso" "base-box" {
  boot_command = [ "a<wait>a<wait>a" ]
  boot_wait = "-1s"
  
  guest_os_type = "Windows11_64"
  iso_url = "./iso/Win11_22H2_English_x64v2.iso"
  iso_checksum = "sha256:8059a99b8902906a90afe068ac00465c52588c2bd54f5d9d96c1297f88ef1076"
  headless = true

  cpus = 2
  memory = 4096
  disk_size = 30000
  firmware = "efi"

  communicator = "winrm"
  winrm_timeout = "6h"
  winrm_insecure = true
  winrm_username = "${var.user}"
  winrm_password = "${var.password}"

  cd_files = [
    "./files/Autounattend.xml",
    "./files/fixnetwork.ps1",
    "./files/enable-winrm.ps1",
    ]

  iso_interface = "sata"

  guest_additions_mode = "disable"
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
}

build {
  source "virtualbox-iso.base-box" {
    name = "win_base_box"
    vm_name = "win_base_box"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/install-7zip.ps1"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/install-guest-additions.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "5m"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/win-updates.ps1"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/disable-screensaver.ps1"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/enable-rdp.ps1"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/set-winrm-automatic.ps1"
  }

  provisioner "powershell" {
    elevated_password = "${var.password}"
    elevated_user     = "${var.user}"
    script            = "./files/install-norgate.ps1"
  }

}