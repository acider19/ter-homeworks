locals {
  subnets_zone_map = { for i, subnet in var.subnets : i => subnet }
}

resource "yandex_vpc_network" "my_vpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "my_subnet" {
  for_each       = local.subnets_zone_map
  name           = "${each.value.zone}-subnet-${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.my_vpc.id
  v4_cidr_blocks = each.value.v4_cidr_blocks
}
