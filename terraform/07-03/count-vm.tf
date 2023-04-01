data "yandex_compute_image" "ubuntu-db" {
  family = var.vm_db_image
}

resource "yandex_compute_instance" "db" {
 count = 2
 name = "netology-develop-platform-db-${count.index}"
 platform_id = "standard-v1"

 resources {
    cores         = var.vm_db_resources.cpu
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-db.image_id
      type = "network-hdd"
      size = 5
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = local.ssh_keys_and_serial_port

}