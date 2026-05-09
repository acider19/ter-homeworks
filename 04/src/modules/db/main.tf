//
// Create a new MDB MySQL Cluster.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  # count = var.ha ? 2 : 1

  name        = var.mdb_name
  environment = "PRESTABLE"
  network_id  = var.vpc_id
  version     = "8.0"

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true

  }

  # host {
  #   zone      = var.zone
  #   subnet_id = var.subnet_id
  # }

  dynamic "host" {
    for_each = var.ha ? toset(["0", "1"]) : ["0"]
    content {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }
}
