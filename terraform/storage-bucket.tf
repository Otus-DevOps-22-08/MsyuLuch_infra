 terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-stage"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "key"
    secret_key = "key"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
