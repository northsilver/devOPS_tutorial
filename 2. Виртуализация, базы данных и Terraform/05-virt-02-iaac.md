- Задание 1
```text
1) Позволяет дорабатывать ПО небольшими изменениями, которые легко контролировать, если применять этот подход, то новые версии не заставят себя ждать.
2) Идемпотентность
```
- Задание 2
```text
1) Низкий порог входа, прост в настройке/управлении
2) Если агенты позволяют отслеживать статус, то Pull. Если нет, то я бы выбрал Push
```
- Задание 3

Vagrant и Virtualbox ставили в первой части лекций, нужно переустановить?
```bash
ivan@ivan-ThinkPad-X395:~$ vagrant --version
Vagrant 2.3.1
ivan@ivan-ThinkPad-X395:~$ vboxmanage --version
6.1.38_Ubuntur153438
```

Установка Ansible
```bash
Установить PIP
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
```
```bash
Установить Ansible
python3 -m pip install --user ansible
```
```bash
Проверка установки
ivan@ivan-ThinkPad-X395:~$ ansible --version
ansible [core 2.14.1]
  config file = None
  configured module search path = ['/home/ivan/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ivan/.local/lib/python3.10/site-packages/ansible
  ansible collection location = /home/ivan/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov  2 2022, 18:53:38) [GCC 11.3.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```