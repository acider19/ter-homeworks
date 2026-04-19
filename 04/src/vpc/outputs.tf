output "vpc_name" {
  value = yandex_vpc_network.my_vpc.name
}

output "vpc_id" {
  value = yandex_vpc_network.my_vpc.id
}

output "subnet_zone" {
  value = yandex_vpc_subnet.my_subnet.zone
}

output "subnet_cidr" {
  value = yandex_vpc_subnet.my_subnet.v4_cidr_blocks
}

output "subnet_id" {
  value = yandex_vpc_subnet.my_subnet.id
}
