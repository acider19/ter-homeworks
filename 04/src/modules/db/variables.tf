variable "mdb_name" {
  type        = string
  default     = "test"
  description = "managed db for tests"
}
variable "vpc_id" {
  type        = string
  default     = ""
  description = "vpc id for the managed db"
}
variable "zone" {
  type        = string
  default     = ""
  description = "zone for the managed db"
}
variable "subnet_id" {
  type        = string
  default     = ""
  description = "subnet id for the managed db"
}
variable "ha" {
  type        = bool
  default     = false
  description = "enable high availability for the managed db"
}
