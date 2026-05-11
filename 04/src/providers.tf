terraform {

  required_version = "~>1.12.0"

  backend "s3" {
    shared_credentials_files = ["~/.aws/credentials"]
    profile                  = "netology"
    bucket                   = "mav-tf-state"
    key                      = "terraform.tfstate"
    region                   = "ru-central1"

    # Встроенный механизм блокировок (Terraform >= 1.6)
    # Не требует отдельной базы данных!
    use_lockfile = true

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
    }
  }
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.authorized_key.json")
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}
