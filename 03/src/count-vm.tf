resource "yandex_compute_instance" "platform1" {
  depends_on  = [yandex_compute_instance.platform2]
  name        = "${var.vm_name}-${count.index + var.delta}"
  platform_id = var.vm_platform_id
  zone        = var.default_zone
  hostname    = "${var.vm_name}-${count.index + var.delta}"
  count       = 2
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
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = var.metadata["ssh-keys"]
  }
}
