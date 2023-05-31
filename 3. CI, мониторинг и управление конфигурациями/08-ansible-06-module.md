- Шаг 1,2,3

[my_own_module.py](https://github.com/northsilver/my_own_collection/blob/master/my_own_module.py)

- Шаг 4

[my_vars.json](https://github.com/northsilver/my_own_collection/blob/master/my_vars.json)

```bash
(venv) ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/ansible$ python3  -m ansible.my_own_module  my_vars.json

{"changed": false, "original_message": "", "message": "file exists", "invocation": {"module_args": {"path": "/home/ivan/proj/my_own_collection/check.module.md", "content": "Worked"}}}
```

- Шаг 5,6

[single task playbook](https://github.com/northsilver/my_own_collection/blob/master/single_task.yml)

```bash
(venv) ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/ansible$ ansible-playbook single_task.yml 
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a
rapidly changing source of code and can become unstable at any point.

PLAY [Test my_own_module] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Create file] ****************************************************************************************************************************************************************************************
changed: [localhost]

PLAY RECAP ************************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

(venv) ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/ansible$ ansible-playbook single_task.yml 
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a
rapidly changing source of code and can become unstable at any point.

PLAY [Test my_own_module] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Create file] ****************************************************************************************************************************************************************************************
ok: [localhost]

PLAY RECAP ************************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0    
```

- Шаг 7,8

```bash
(venv) ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/ansible$ deactivate
ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/ansible$ ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a
rapidly changing source of code and can become unstable at any point.
- Collection my_own_namespace.yandex_cloud_elk was created successfully
```

- Шаг 9

модуль разместил в
`my_own_collection/my_own_namespace/yandex_cloud_elk/plugins/modules`

- Шаг 10,11

[single task role ](https://github.com/northsilver/my_own_collection/blob/1.0.0/single_role.yml)

- Шаг 12

[1.0.0](https://github.com/northsilver/my_own_collection/tree/1.0.0/my_own_namespace)

- Шаг 13

```bash
ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/my_own_namespace/yandex_cloud_elk$ ansible-galaxy collection build
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a
rapidly changing source of code and can become unstable at any point.
Created collection for my_own_namespace.yandex_cloud_elk at /home/ivan/proj/my_own_collection/my_own_namespace/yandex_cloud_elk/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz
```

- Шаг 14,15

```bash
ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/test$ ansible-galaxy collection install my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz 
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a
rapidly changing source of code and can become unstable at any point.
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'my_own_namespace.yandex_cloud_elk:1.0.0' to '/home/ivan/.ansible/collections/ansible_collections/my_own_namespace/yandex_cloud_elk'
my_own_namespace.yandex_cloud_elk:1.0.0 was installed successfully
```

- Шаг 16

```bash
ivan@ivan-ThinkPad-X395:~/proj/my_own_collection/test$ ansible-playbook single_role_collection.yml 
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a
rapidly changing source of code and can become unstable at any point.

PLAY [Test my_own_module] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [localhost]

TASK [my_own_namespace.yandex_cloud_elk.my_own_module : Test my_own_module] *******************************************************************************************************************************
ok: [localhost]

PLAY RECAP ************************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
- Шаг 17

[Collection](https://github.com/northsilver/my_own_collection/blob/master/my_own_namespace/yandex_cloud_elk/README.md)

[Tar.gz](https://github.com/northsilver/my_own_collection/blob/master/test/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz)