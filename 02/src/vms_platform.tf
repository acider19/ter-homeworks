# common vars
variable "image" {
  type        = string
  description = "image name"
}

# # vm web vars
# variable "vm_web_cores" {
#   type        = number
#   description = "number of CPU cores"
# }

# variable "vm_web_memory" {
#   type        = number
#   description = "RAM in GB"
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   description = "percent usage CPU"
# }

# variable "vm_web_name" {
#   type        = string
#   description = "VM name"
# }

variable "vm_web_platform_id" {
  type        = string
  description = "platform type"
}

# vm db vars
# variable "vm_db_cores" {
#   type        = number
#   description = "number of CPU cores"
# }

# variable "vm_db_memory" {
#   type        = number
#   description = "RAM in GB"
# }

# variable "vm_db_core_fraction" {
#   type        = number
#   description = "percent usage CPU"
# }

# variable "vm_db_name" {
#   type        = string
#   description = "VM name"
# }

variable "vm_db_platform_id" {
  type        = string
  description = "platform type"
}
