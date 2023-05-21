- Задание 1

[requirements.yml](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/requirements.yml)

- Задание 2

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-galaxy install -r requirements.yml -p roles
Starting galaxy role install process
- extracting clickhouse to /home/ivan/proj/devOPS_tutorial/Files/08-ansible-04-role/playbook/roles/clickhouse
- clickhouse (1.11.0) was installed successfully
```

- Задание 3

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-galaxy role init vector-role
- Role vector-role was created successfully
```

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-galaxy role init lighthouse-role
- Role vector-role was created successfully
```

- Задание 4

[Default для Vector](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/vector-role/defaults/main.yml)

[Vars для Vector](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/vector-role/vars/main.yml)

- Задание 5

[Templates](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-04-role/playbook/vector-role/templates)

- Задание 6,7,8,9

[Описание ролей](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/README.md)

- Задание 10

[Playbook](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-04-role/playbook)

- Задание 11

[Vector](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-04-role/playbook/vector-role)

[Lighthouse](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-04-role/playbook/lighthouse-role)