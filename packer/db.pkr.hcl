variable "folder_id" {
    type = string
    default = ""
}

variable "path_to_keyfile" {
    type = string
    default = ".ssh/key.json"
}

variable "source_image_family" {
    type = string
    default = "ubuntu-1604-lts"
}

variable "subnet_id" {
    type = string
    default = ""
}

variable "zone" {
    type = string
    default = "ru-central1-a"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "yandex" "autogenerated_1" {
    service_account_key_file  = var.path_to_keyfile
    folder_id                 = var.folder_id
    source_image_family       = var.source_image_family
    image_name                = "reddit-base-db-${local.timestamp}"
    image_family              = "reddit-base"
    ssh_username              = "ubuntu"
    subnet_id                 = var.subnet_id
    zone                      = var.zone
    platform_id               = "standard-v1"
    use_ipv4_nat              = "true"
  }

  build {
    sources = ["source.yandex.autogenerated_1"]

    provisioner "shell" {
        script          = "scripts/install_mongodb.sh"
        execute_command = "sudo {{.Path}}"
    }
  }