- Задание 1

Добавил в [main.tf](https://github.com/northsilver/devOPS_tutorial/blob/terraform-04/terraform/07-04/main.tf)
```terraform
  vars = {
      username           = var.username
      ssh_public_key     = file(var.ssh_public_key)
      packages           = jsonencode(var.packages)
   }
```
Добавил в [variables.tf](https://github.com/northsilver/devOPS_tutorial/blob/terraform-04/terraform/07-04/variables.tf)
```terraform
variable username {
  type = string
}
variable ssh_public_key {
  type        = string
  description = "Location of SSH public key."
}   
variable packages {
  type    = list
  default = []
}
```
Добавил в [cloud-init.yml](https://github.com/northsilver/devOPS_tutorial/blob/terraform-04/terraform/07-04/cloud-init.yml)
```terraform
    ssh_authorized_keys:
      - ${ssh_public_key}
```
Добавить исключение в personal.auto.tfvars
```terraform
ssh_public_key = "~/.ssh/id_rsa.pub"
```
Установка nginx в cloud-init
```terraform
packages:
  - vim
  - nginx
```

[Скриншот подключения](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-04-07%2012-59-57.png?raw=true)

- Задание 2

Создал модуль vpc_module и другие задачи задания

[Ссылка на ветку с модулем](https://github.com/northsilver/devOPS_tutorial/tree/terraform-04/terraform/07-04)

- Задание 3

Проверка state и удаление
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/ter-homeworks/04/demonstration1$ terraform state list
data.template_file.cloudinit
module.test-vm.data.yandex_compute_image.my_image
module.test-vm.yandex_compute_instance.vm[0]
module.test-vm.yandex_compute_instance.vm[1]
module.vpc_module.null_resource.Creation_of_documentation
module.vpc_module.yandex_vpc_network.develop
module.vpc_module.yandex_vpc_subnet.develop
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/ter-homeworks/04/demonstration1$ terraform state rm 'module.vpc_module'
Removed module.vpc_module.null_resource.Creation_of_documentation
Removed module.vpc_module.yandex_vpc_network.develop
Removed module.vpc_module.yandex_vpc_subnet.develop
Successfully removed 3 resource instance(s).
```
ID модуля нашел в бэкапе state
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/ter-homeworks/04/demonstration1$ grep -HiRn -e  'module.vpc_module.' -e '"id"' -e '"type"' ./terraform.tfstate.backup
./terraform.tfstate.backup:10:      "type": "template_file",
./terraform.tfstate.backup:18:            "id": "6d0438e402d0e2889d2d93e81ee0f7fe3c961a9411a1b5091287a01a05157da8",
./terraform.tfstate.backup:34:      "type": "yandex_compute_image",
./terraform.tfstate.backup:45:            "id": "fd8tckeqoshi403tks4l",
./terraform.tfstate.backup:65:      "type": "yandex_compute_instance",
./terraform.tfstate.backup:88:                    "type": "network-hdd"
./terraform.tfstate.backup:101:            "id": "fhm3h3phsd5dvv78ccpt",
./terraform.tfstate.backup:170:            "module.vpc_module.yandex_vpc_network.develop",
./terraform.tfstate.backup:171:            "module.vpc_module.yandex_vpc_subnet.develop"
./terraform.tfstate.backup:193:                    "type": "network-hdd"
./terraform.tfstate.backup:206:            "id": "fhmu40j9caaae6van03e",
./terraform.tfstate.backup:275:            "module.vpc_module.yandex_vpc_network.develop",
./terraform.tfstate.backup:276:            "module.vpc_module.yandex_vpc_subnet.develop"
./terraform.tfstate.backup:282:      "module": "module.vpc_module",
./terraform.tfstate.backup:284:      "type": "null_resource",
./terraform.tfstate.backup:291:            "id": "1995314574818252480",
./terraform.tfstate.backup:301:      "module": "module.vpc_module",
./terraform.tfstate.backup:303:      "type": "yandex_vpc_network",
./terraform.tfstate.backup:314:            "id": "enp5ld802ni78t6fqukl",
./terraform.tfstate.backup:326:      "module": "module.vpc_module",
./terraform.tfstate.backup:328:      "type": "yandex_vpc_subnet",
./terraform.tfstate.backup:339:            "id": "e9bv91m1t60r7qj0nk5c",
./terraform.tfstate.backup:354:            "module.vpc_module.yandex_vpc_network.develop"
```
Import
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/ter-homeworks/04/demonstration1$ terraform import 'module.vpc_module.yandex_vpc_network.develop' 'enp5ld802ni78t6fqukl'
var.username
  Enter a value: ubuntu

data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=6d0438e402d0e2889d2d93e81ee0f7fe3c961a9411a1b5091287a01a05157da8]
module.vpc_module.yandex_vpc_network.develop: Importing from ID "enp5ld802ni78t6fqukl"...
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc_module.yandex_vpc_network.develop: Import prepared!
  Prepared yandex_vpc_network for import
module.vpc_module.yandex_vpc_network.develop: Refreshing state... [id=enp5ld802ni78t6fqukl]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8tckeqoshi403tks4l]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/ter-homeworks/04/demonstration1$ terraform import 'module.vpc_module.yandex_vpc_subnet.develop' 'e9bv91m1t60r7qj0nk5c'
var.username
  Enter a value: ubuntu

data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=6d0438e402d0e2889d2d93e81ee0f7fe3c961a9411a1b5091287a01a05157da8]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc_module.yandex_vpc_subnet.develop: Importing from ID "e9bv91m1t60r7qj0nk5c"...
module.vpc_module.yandex_vpc_subnet.develop: Import prepared!
  Prepared yandex_vpc_subnet for import
module.vpc_module.yandex_vpc_subnet.develop: Refreshing state... [id=e9bv91m1t60r7qj0nk5c]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8tckeqoshi403tks4l]

Import successful!

The resources that were imported are shown above. These resources are now in
```

Terraform plan

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/ter-homeworks/04/demonstration1$ terraform plan
var.username
  Enter a value: ubuntu

data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=6d0438e402d0e2889d2d93e81ee0f7fe3c961a9411a1b5091287a01a05157da8]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc_module.yandex_vpc_network.develop: Refreshing state... [id=enp5ld802ni78t6fqukl]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8tckeqoshi403tks4l]
module.vpc_module.yandex_vpc_subnet.develop: Refreshing state... [id=e9bv91m1t60r7qj0nk5c]
module.test-vm.yandex_compute_instance.vm[1]: Refreshing state... [id=fhmu40j9caaae6van03e]
module.test-vm.yandex_compute_instance.vm[0]: Refreshing state... [id=fhm3h3phsd5dvv78ccpt]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vpc_module.null_resource.Creation_of_documentation will be created
  + resource "null_resource" "Creation_of_documentation" {
      + id       = (known after apply)
      + triggers = {}
    }

Plan: 1 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
