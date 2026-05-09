output "vpc_name" {
  value = yandex_vpc_network.my_vpc.name
}

output "vpc_id" {
  value = yandex_vpc_network.my_vpc.id
}

output "subnet_zone" {
  value = {
    for k, subnet in yandex_vpc_subnet.my_subnet : k => subnet.zone
  }
}

output "subnet_cidr" {
  value = {
    for k, subnet in yandex_vpc_subnet.my_subnet : k => subnet.v4_cidr_blocks
  }
}

output "subnet_id" {
  value = {
    for k, subnet in yandex_vpc_subnet.my_subnet : k => subnet.id
  }
}
