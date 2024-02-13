# vpc
resource "yandex_vpc_network" "network-diplom" {
  name = "network-diplom"
  folder_id = var.yc_folder_id
}

# subnets
resource "yandex_vpc_subnet" "subnet-first" {
  name           = "subnet-first"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-diplom.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-second" {
  name           = "subnet-second"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-diplom.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet-third" {
  name           = "subnet-third"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-diplom.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}