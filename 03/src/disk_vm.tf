locals {
  all_disk_ids = { for disk_id_num in range(var.num_of_disk) : disk_id_num => { disk_id = yandex_compute_disk.my_disk[disk_id_num].id } }
}

resource "yandex_compute_disk" "my_disk" {
  name  = "${var.disk_name}-${count.index}"
  type  = var.disk_type
  zone  = var.default_zone
  size  = var.disk_size
  count = var.num_of_disk
}

resource "yandex_compute_instance" "platform3" {
  name        = var.storage_name
  platform_id = var.vm_platform_id
  zone        = var.default_zone
  hostname    = var.storage_name
  resources {
    cores         = var.vms_resources.web["cores"]
    memory        = var.vms_resources.web["memory"]
    core_fraction = var.vms_resources.web["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  allow_stopping_for_update = true
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  dynamic "secondary_disk" {
    for_each = local.all_disk_ids
    content {
      disk_id = lookup(secondary_disk.value, "disk_id", null)
    }
  }

  metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = var.metadata["ssh-keys"]
  }
}
