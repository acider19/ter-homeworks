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

variable "sa_name" {
  type        = string
  description = "name of the service account to create"
  default     = "tfstate"
}

variable "profile_name" {
  type        = string
  description = "name of the profile to create in AWS credentials file"
  default     = "yc"
}
