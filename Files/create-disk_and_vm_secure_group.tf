resource "yandex_compute_disk" "create-disk" {
  count = 3
  name        = "disk-${count.index}"
  type       = var.create-disk.type
  zone       = var.default_zone
  size       = var.create-disk.size
  block_size = var.create-disk.block_size
}
resource "yandex_compute_instance" "create-vm" {
  name        = "VM"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm_db_resources.cpu
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic secondary_disk {
    for_each = "${yandex_compute_disk.create-disk.*.id}"

    content {
      disk_id = yandex_compute_disk.create-disk["${secondary_disk.key}"].id
      auto_delete = var.create-disk.auto_delete
    }

 }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
    security_group_ids = [
      "${yandex_vpc_security_group.example.id}"
    ]
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = local.ssh_keys_and_serial_port.ssh-keys
  }
  allow_stopping_for_update = true

  depends_on = [
    yandex_compute_disk.create-disk,
    yandex_vpc_security_group.example,
    yandex_vpc_subnet.develop
  ]

}
