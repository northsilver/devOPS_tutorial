terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
    packages       = jsonencode(var.packages)
  }
}

resource "yandex_compute_image" "nat-instance-ubuntu" {
  source_family = "nat-instance-ubuntu"
}

resource "yandex_compute_image" "vm" {
  source_family = "ubuntu-2204-lts"
}

#Создаём пустую VPC
resource "yandex_vpc_network" "netology" {
  name = var.vpc_name
}
resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = "nat-instance-sg"
  network_id = yandex_vpc_network.netology.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}
#Создаём в VPC subnet с названием public, сетью 192.168.10.0/24.
resource "yandex_vpc_subnet" "public" {
  name           = var.subnet_public
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.default_cidr

}

#Создаём в подсети NAT-инстанс, присвоив ему адрес 192.168.10.254
resource "yandex_compute_instance" "nat-instance" {
  name        = "nat-instance"
  hostname    = "nat-instance"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    core_fraction = var.vm_resources.core_fraction
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.nat-instance-ubuntu.id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true
    ip_address         = "192.168.10.254"
  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
  }
}


#Создаём в публичной подсети VM с публичным IP
resource "yandex_compute_instance" "vm-public" {
  name        = "vm-public"
  hostname    = "vm-public"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    core_fraction = var.vm_resources.core_fraction
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.vm.id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true

  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
  }
}

#Создаём в VPC subnet с названием private и сетью 192.168.20.0/24.
resource "yandex_vpc_subnet" "private" {
  name           = var.subnet_private
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

#Создаём route table. Добавляем статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.netology.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}

#Создаём в приватной подсети VM с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.
resource "yandex_compute_instance" "vm-private" {
  name        = "vm-private"
  hostname    = "vm-private"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    core_fraction = var.vm_resources.core_fraction
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.vm.id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = false

  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
  }
}
