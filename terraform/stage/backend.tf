terraform {

  required_version = "~> 0.12.8"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-stage"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YCAJEvO2CzrgYP5uA613xcizj"
    secret_key = "YCM5j2O7berHSDdSoUyTnPf9lYH-Z1IjFDf6mMRl"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
