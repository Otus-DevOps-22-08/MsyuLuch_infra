 terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-stage"
    region     = "ru-central1"
    key        = "terraform.tfstate"

    access_key = "EXAMPLE_KEY"
    secret_key = "EXAMPLE_KEY"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
