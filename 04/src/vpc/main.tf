terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.authorized_key.json")
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "zone_b" {
  type        = string
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

module "project_vpc" {
  source   = "../modules/vpc"
  vpc_name = var.vpc_name
  subnets = [
    {
      zone           = var.default_zone
      v4_cidr_blocks = var.default_cidr
    },
    {
      zone           = var.zone_b
      v4_cidr_blocks = var.cidr_b
    }
  ]
}

output "vpc_id" {
  value = module.project_vpc.vpc_id
}

output "vpc_name" {
  value = module.project_vpc.vpc_name
}

output "vpc_subnet_id" {
  value = {
    for k, subnet in module.project_vpc.subnet_id : k => subnet
  }
}

output "vpc_subnet_zone" {
  value = {
    for k, zone in module.project_vpc.subnet_zone : k => zone
  }
}
