###cloud vars

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
# variable "zone_b" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
# }

# variable "default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }
# variable "cidr_b" {
#   type        = list(string)
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

# variable "vpc_name" {
#   type        = string
#   default     = "develop"
#   description = "VPC network&subnet name"
# }
variable "image" {
  type        = string
  description = "os image for vms"
}

# common vars

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}
variable "vms_username" {
  type        = string
  description = "vms username"
}
variable "vms_packages" {
  type        = list(string)
  description = "packages for install on vms"
  default     = ["nginx", "jq", "curl"]
}

# vms instance name
variable "vm_marketing_name" {
  type        = string
  description = "name for marketing vm instance"
}
variable "vm_analytics_name" {
  type        = string
  description = "name for analytics vm instance"
}

# managed db vars
variable "ha" {
  type        = bool
  default     = true
  description = "enable high availability for the managed db"
}
variable "mdb_name" {
  type        = string
  description = "name for managed db instance"
}
variable "db_user" {
  type        = string
  description = "username for managed db instance"
}
variable "db_password" {
  type        = string
  description = "password for managed db instance"
  sensitive   = true
}
variable "db_name" {
  type        = string
  description = "name for managed db instance"
}

# vault vars
variable "vault_token" {
  type        = string
  description = "vault token"
}
