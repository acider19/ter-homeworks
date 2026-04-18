output "vms_info_map" {
  value = [
    concat(
      [for a in yandex_compute_instance.platform1 : { name = a.name, id = a.id, fqdn = a.fqdn }],
      [for b in yandex_compute_instance.platform2 : { name = b.name, id = b.id, fqdn = b.fqdn }]
    )
  ]
}
