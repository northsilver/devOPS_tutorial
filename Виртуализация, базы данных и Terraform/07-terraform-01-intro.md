- Задание 1
1. Ответить на четыре вопроса из раздела «Легенда».
Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
```text
Неизменяемый
```
Будет ли центральный сервер для управления инфраструктурой?
```text
Лучше использовать два(или кластер если позволяют ресурсы) один для управления, второй для локального гита.
```
Будут ли агенты на серверах?
```text
Нет, через ssh
```
Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?
```text
Да, Terraform.
```
2. Решить, какие инструменты из уже используемых вы хотели бы применить для нового проекта.
```text
Packer, Terraform, Docker, Kubernetes, Ansible.
```
3. Определиться, хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта.
```text
Teamcity лучше заменить на GitLab
```

- Задание 2
```text
ivan@ivan-ThinkPad-X395:~$ terraform --version
Terraform v1.4.2
on linux_amd64
```

- Задание 3
Использовать Terraform Switcher
```text
ivan@ivan-ThinkPad-X395:~$ terraform --version
Terraform v1.4.2
on linux_amd64
```
Переключение
```text
ivan@ivan-ThinkPad-X395:~$ tfswitch 1.3.7
Installing terraform at /home/ivan/bin
Switched terraform to version "1.3.7"
```
```text
ivan@ivan-ThinkPad-X395:~$ terraform --version
Terraform v1.3.7
on linux_amd64
```

