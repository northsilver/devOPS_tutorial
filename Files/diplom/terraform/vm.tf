# VM
resource "yandex_compute_instance" "master-vm" {
  name = "master-vm"
  hostname = "master-vm"
  zone      = "ru-central1-a"
  resources {
    cores  = 4
    memory = 8
  }
  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
      size = "20"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-first.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker-vm-1" {
  name = "worker-vm-1"
  hostname = "worker-vm-1"
  zone      = "ru-central1-a"
  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
      size = "20"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-first.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker-vm-2" {
  name = "worker-vm-2"
  hostname = "worker-vm-2"
  zone      = "ru-central1-b"
  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
      size = "20"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-second.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker-vm-3" {
  name = "worker-vm-3"
  hostname = "worker-vm-3"
  zone      = "ru-central1-c"
  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
      size = "20"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-third.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}