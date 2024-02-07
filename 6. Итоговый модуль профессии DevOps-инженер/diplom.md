# Дипломный практикум в Yandex.Cloud

## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.


## Оглавление
* [Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.](#1)
* [Запустить и сконфигурировать Kubernetes кластер.](#2)
* [Установить и настроить систему мониторинга.](#3)
* [Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.](#4)
* [Настроить CI для автоматической сборки и тестирования.](#5)
* [Настроить CD для автоматического развёртывания приложения.](#6)


## [Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.](#1)

### Подготовка инструментов для работы YC

```bash
ivan@ivan-ThinkPad-X395:~ yc config list
token: y0_*******_grrDio0
cloud-id: b1gs6fqvan6645otctmr
folder-id: b1gl8p7gd9kjf5d599cd
compute-default-zone: ru-central1-a
ivan@ivan-ThinkPad-X395:~ yc iam create-token
t1.9eue*****jkETavwBg
ivan@ivan-ThinkPad-X395:~ export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
export YC_ZONE=$(yc config get compute-default-zone)
```

### Создание основного main файла

#### Создадим основной манифест, который:
1. использует переменные для ЯО
2. создает сервисный аккаунт с необходимыми правами
3. создает S3-bucket и использует его как backend
4. создает VPC с подсетями в разных зонах доступности

[main.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Fs______.yaml)
```bash
# yc ver&var
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.14"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone = var.yc_zone
}

# variables
variable "yc_token" {
  default = "t1.9eue*****jkETavwBg"
}
variable "yc_cloud_id" {
  default = "b1gs6fqvan6645otctmr"
}
variable "yc_folder_id" {
  default = "b1gl8p7gd9kjf5d599cd"
}
variable "yc_zone" {
  default = "ru-central1-a"
}

# service account
resource "yandex_iam_service_account" "svc-for-diplom" {
  folder_id = var.yc_folder_id
  name        = "svc-for-diplom"
}
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.svc-for-diplom.id}"
}

# bucket-key
resource "yandex_iam_service_account_static_access_key" "accesskey-bucket" {
  service_account_id = yandex_iam_service_account.svc-for-diplom.id
}

# bucket-create
resource "yandex_storage_bucket" "diplom-shumbasov" {
  access_key = yandex_iam_service_account_static_access_key.accesskey-bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.accesskey-bucket.secret_key
  bucket     = "diplom-shumbasov"
  default_storage_class = "STANDARD"
  acl           = "public-read"
  force_destroy = "true"
  anonymous_access_flags {
    read = true
    list = true
    config_read = true
  }
}
```

[backend.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Fs______.yaml)

```bash
terraform {
  backend "s3" {
    endpoint       = "storage.yandexcloud.net"
    bucket         = "diplom-shumbasov"
    key            = "terraform.tfstate"
    region         = "ru-central1-a"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
```
Выполним команду для использования ключей сервисного аккаунта в качестве переменных среды
```bash
ivan@ivan-ThinkPad-X395:~$ export AWS_ACCESS_KEY_ID=YCA****dN0
ivan@ivan-ThinkPad-X395:~$ export AWS_SECRET_ACCESS_KEY=YCPryjN8atkZO*******DybYz7P
ivan@ivan-ThinkPad-X395:~$ terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
```
Применим манифест
```bash
ivan@ivan-ThinkPad-X395:~$ terraform init

Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes


Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.106.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Скриншот успешного создания S3

![S3](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Scrg)

Добавим в [main.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Fs______.yaml) создание VPC
```bash
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
```
Скриншот успешного создания VPC

![VPC](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Scrg)



