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

###common vars

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

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
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

# # vars for validate
variable "var1" {
  type        = string
  description = "ip-address for validate"
  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.var1))
    error_message = "not valid ip-address"
  }
}
variable "var2" {
  type        = list(string)
  description = "list of ip-addresses for validate"
  validation {
    condition = alltrue([
      for ip in var.var2 : can(cidrhost("${ip}/32", 0))
    ])
    error_message = "not valid ip-address in list"
  }
}

# # var for task 5
variable "cap_sym" {
  type        = string
  description = "string without capital letters"
  validation {
    condition     = can(regex("^[^A-Z]*$", var.cap_sym))
    error_message = "string contains capital letters"
  }
}

variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition     = (((var.in_the_end_there_can_be_only_one.Dunkan) && (var.in_the_end_there_can_be_only_one.Connor) == true) || ((var.in_the_end_there_can_be_only_one.Dunkan) || (var.in_the_end_there_can_be_only_one.Connor) == false)) == false
  }
}
