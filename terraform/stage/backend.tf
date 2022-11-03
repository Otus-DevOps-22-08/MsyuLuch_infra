 terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-stage"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YCAJEnuUUmY67a2Z50Seb_Hu6"
    secret_key = "YCMoiFR_zkwX0a3zOTkbXoEgoEDuA3wCYF3CpNsu"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
