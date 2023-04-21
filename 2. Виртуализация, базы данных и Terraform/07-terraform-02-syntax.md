- Задание 1

 ```text
В файле main.tf в cores указан 1 процессор, а standard-v1 поддерживает только 2,4 и тд.
```
 ```text
preemptible = true - позволяет прерывать ВМ в любой момент, можно останавливать и экономить
core_fraction - фракционность ядра, т.е. доля вычислительного времени, можно более гибко настроить необходимые потребности
 ```

[Личный кабинет](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-03-26%2020-27-20.png)

```text
ivan@ivan-ThinkPad-X395:~$ ssh ubuntu@158.160.44.236
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.4.0-137-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@fhm2u32ne6f7cb90amos:~$ 
```

- Задание 2

Добавил в variables

```text
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name instance"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description =  "Сore resourse"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description =  "Core fraction"
}
variable "vm_web_memory" {
  type        = number
  default     = 1
  description =  "Memory"
}
 ```

- Задание 3

Добавил в файл vms_platform конфигурацию DB

```text
variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name instance"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description =  "Сore resource"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description =  "Сore fraction"
}
variable "vm_db_memory" {
  type        = number
  default     = 2
  description =  "Мemory"
}
 ```

- Задание 4

```text
output "ip_web_address" {
value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
description = "vm_web_external_ip"
}

output "ip_db_address" {
value = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
description = "vm_db_external_ip"
}

ivan@ivan-ThinkPad-X395:~$ terraform output
Outputs:

ip_web_address = "178.154.203.223"
ip_db_address = "178.154.204.46"
 ```

- Задание 5

В vms_platform.tf и variables.tf закоментировал блок "vm_web_name" и "vm_db_name"
В locals добавил
 ```text
locals {
  vm_web = "netology-${var.vpc_name}-platform-web"
  vm_db  = "netology-${var.vpc_name}-platform-db"
}
```
В main добавил и закоментировал
 ```text
###web
 resource "yandex_compute_instance" "platform" {
  #name        = var.vm_web
  name        = local.vm_web

###db
resource "yandex_compute_instance" "platform-db" {
  #name        = var.vm_db
  name        = local.vm_db
```

- Задание 6

В vms_platform.tf добавил блоки
 ```text
variable "vm_web_resources" {
  type        = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "vm_db_resources" {
  type        = map(number)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

variable "metadata" {
  type        = map(any)
  default = {
    vm_serial-port-enable = 1
    vms_ssh_root_key      = "ubuntu:key"
  }
}
```
в main внес изменения
 ```text
resource "yandex_compute_instance" "platform" {
  #name        = var.vm_web_name
  name        = local.vm_web
  platform_id = "standard-v1"
  resources {
    cores         = var.vm_web_resources["cores"]
    memory        = var.vm_web_resources["memory"]
    core_fraction = var.vm_web_resources.core_fraction

resource "yandex_compute_instance" "platform-db" {
  #name        = var.vm_db_name
  name        = local.vm_db
  platform_id = "standard-v1"
  resources {
    cores         = var.vm_db_resources["cores"]
    memory        = var.vm_db_resources["memory"]
    core_fraction = var.vm_db_resources.core_fraction

metadata = var.metadata
```
