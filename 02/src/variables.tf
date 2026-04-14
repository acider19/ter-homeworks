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
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "zone_b" {
  type        = string
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "cidr_b" {
  type        = list(string)
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  description = "VPC network & subnet name"
}


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   sensitive   = true
#   description = "ssh-keygen -t ed25519"
# }

variable "site" {
  type        = string
  description = "site name"
}
variable "env" {
  type        = string
  description = "environment name"
}
variable "vm_type" {
  type        = string
  description = "vm type"
}

# merged vars
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  description = "for all vms"
}

variable "metadata" {
  type = object({
    serial-port-enable = string
    ssh-keys           = string
  })
  sensitive = true
}

variable "test" {
  type = tuple([
    object({
      dev1 = list(string)
    }),
    object({
      dev2 = list(string)
    }),
    object({
      prod1 = list(string)
    })
  ])
}
