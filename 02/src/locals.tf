# netology-develop-platform-web

locals {
  name_web = "${var.site}-${var.env}-${var.vm_type}-web"
  name_db  = "${var.site}-${var.env}-${var.vm_type}-db"
}
