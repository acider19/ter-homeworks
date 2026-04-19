resource "yandex_vpc_network" "my_vpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "my_subnet" {
  name           = "develop-ru-central1-a"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.my_vpc.id
  v4_cidr_blocks = var.default_cidr
}
