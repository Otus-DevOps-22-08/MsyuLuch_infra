 terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-stage"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "KEY"
    secret_key = "KEY"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
