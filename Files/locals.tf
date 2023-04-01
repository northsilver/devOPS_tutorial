locals {
  env = "dev"
  project = "platform"
  role1 = "db"
  role2 = "web"
}

locals {
  db_name = "netology-${ local.env }-${ local.project }-${ local.role1}"
  web_name  = "netology-${ local.env }-${ local.project }-${ local.role2}"
}

locals {
 ssh_keys_and_serial_port = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }
}