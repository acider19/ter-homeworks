
output "vms_info_map" {
  value = {
    web_name = yandex_compute_instance.platform.name,
    web_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address,
    web_fqdn = yandex_compute_instance.platform.fqdn,
    db_name  = yandex_compute_instance.platform_db.name,
    db_ip    = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address,
    db_fqdn  = yandex_compute_instance.platform_db.fqdn

  }

}
