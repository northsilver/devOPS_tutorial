- Задание 1

1. [Исходящий трафик](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-04-01%2018-21-52.png?raw=true)
2. [Входящий трафик](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-04-01%2018-22-07.png?raw=true)


- Задание 2

1. [count-vm.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/count-vm.tf)
2. [for_each-vm.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/for_each-vm.tf)
3. Добавил depends_on = [yandex_compute_instance.db]
4. [locals.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/locals.tf)

- Задание 3

[create-disk_and_vm_secure_group.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/create-disk_and_vm_secure_group.tf)

- Задание 4

[main.tf](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/07-03-main.tf)

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/terraform/07-03$ cat hosts.cfg 
[dbservers]

netology-develop-platform-db-0   ansible_host=158.160.56.12
netology-develop-platform-db-1   ansible_host=158.160.58.17
```

[Ссылка на ветку](https://github.com/northsilver/devOPS_tutorial/tree/terraform-03/terraform/07-03)