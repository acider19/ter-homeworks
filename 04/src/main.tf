# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop_a" {
#   name           = "develop-ru-central1-a"
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

# resource "yandex_vpc_subnet" "develop_b" {
#   name           = "develop-ru-central1-b"
#   zone           = var.zone_b
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.cidr_b
# }

module "project_vpc" {
  source       = "./vpc"
  vpc_name     = var.vpc_name
  default_zone = var.default_zone
  default_cidr = var.default_cidr
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = module.project_vpc.vpc_name
  network_id     = module.project_vpc.vpc_id
  subnet_zones   = [module.project_vpc.subnet_zone]
  subnet_ids     = [module.project_vpc.subnet_id]
  instance_name  = var.vm_marketing_name
  instance_count = 1
  image_family   = var.image
  public_ip      = true

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data          = local.user_data
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = module.project_vpc.vpc_name
  network_id     = module.project_vpc.vpc_id
  subnet_zones   = [module.project_vpc.subnet_zone]
  subnet_ids     = [module.project_vpc.subnet_id]
  instance_name  = var.vm_analytics_name
  instance_count = 1
  image_family   = var.image
  public_ip      = true

  labels = {
    project = "analytics"
  }

  metadata = {
    user-data          = local.user_data
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yaml")
# }

locals {
  user_data = templatefile("${path.module}/cloud-init.yaml", {
    username       = var.vms_username
    ssh_public_key = file(var.vms_ssh_root_key)
    packages       = jsonencode(var.vms_packages)
  })
}
