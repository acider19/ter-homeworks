# создание ВМ
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = data.terraform_remote_state.vpc.outputs.vpc_name
  network_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_zones   = [data.terraform_remote_state.vpc.outputs.vpc_subnet_zone["0"]]
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.vpc_subnet_id["0"]]
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

# создание ВМ
module "analytics_vm" {
  depends_on     = [module.marketing_vm]
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = data.terraform_remote_state.vpc.outputs.vpc_name
  network_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_zones   = [data.terraform_remote_state.vpc.outputs.vpc_subnet_zone["1"]]
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.vpc_subnet_id["1"]]
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

# создание кластера MDB
# module "project_mdb" {
#   source    = "./modules/db"
#   vpc_id    = data.terraform_remote_state.vpc.outputs.vpc_id
#   mdb_name  = var.mdb_name
#   zone      = data.terraform_remote_state.vpc.outputs.vpc_subnet_zone["0"]
#   subnet_id = data.terraform_remote_state.vpc.outputs.vpc_subnet_id["0"]
#   ha        = var.ha
# }

# создание базы данных и пользователя
# module "create_db" {
#   source      = "./modules/create_db"
#   count       = var.enable_mysql ? 1 : 0
#   cluster_id  = module.project_mdb.cluster_id
#   db_name     = var.db_name
#   db_user     = var.db_user
#   db_password = var.db_password
# }

# создание user_data для ВМ
locals {
  user_data = templatefile("${path.module}/cloud-init.yaml", {
    username       = var.vms_username
    ssh_public_key = file(var.vms_ssh_root_key)
    packages       = jsonencode(var.vms_packages)
  })
}

# создание S3 бакета
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3_bucket" {
  source      = "git::https://github.com/terraform-yc-modules/terraform-yc-s3"
  bucket_name = "simple-bucket-${random_string.unique_id.result}"
  versioning = {
    enabled = true
  }
}

# чтение данных из Vault
# data "vault_generic_secret" "vault_example" {
#   path = "secret/example"
# }

# запись данных в Vault
# resource "vault_generic_secret" "my_example" {
#   path = "secret/my_example"

#   data_json = jsonencode(
#     {
#       "name" = "artyom"
#     }
#   )
# }

# чтение данных из remote state vpc
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "./vpc/terraform.tfstate"
  }
}

# чтение данных из remote state backend
data "terraform_remote_state" "backend" {
  backend = "local"
  config = {
    path = "./backend/terraform.tfstate"
  }
}
