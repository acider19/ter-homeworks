locals {
  vms_map = { for vm in var.each_vm : vm.vm_name => vm }
}

resource "yandex_compute_instance" "platform2" {
  for_each    = local.vms_map
  name        = each.value.vm_name
  platform_id = var.vm_platform_id
  zone        = var.default_zone
  hostname    = each.value.vm_name
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fr
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
      type     = "network-hdd"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = var.metadata["ssh-keys"]
  }
}
