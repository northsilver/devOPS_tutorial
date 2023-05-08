- Задание 1
```bash
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 84.201.130.243

vector:
  hosts:
    vector-01:
      ansible_host: 158.160.51.202
```
- Задание 2,3,4
```bash
 - name: Install Vector
  hosts: vector
  handlers:
    - name: Start Vector service
      become: true
      ansible.builtin.service:
        name: vector
        state: restarted
  tasks:
    - name: Get Vector version
      become: true
      ansible.builtin.command: vector --version
      register: vector_installed
      failed_when: vector_installed.rc !=0
      changed_when: vector_installed.rc ==0
      ignore_errors: true
    - name: Create directory vector
      become: true
      file:
        path: "{{ vector_path }}"
        state: directory
    - name: Get vector distrib
      ansible.builtin.get_url:
        url: "https://packages.timber.io/vector/{{ vector_version }}/vector_{{ vector_version }}-1.x86_64.rpm"
        dest: "./vector-{{ vector_version }}.rpm"
    - name: Install vector packages
      become: true
      ansible.builtin.apt:
        deb: ./vector-{{ vector_version }}.rpm
      notify: Start vector service
    - name: Configuring service vector
      become: true
      systemd:
        name: vector
        state: "started"
        enabled: true
        daemon_reload: true
```
- Задание 5
Была ошибка переноса строки, сразу ее убрал, поэтому не попала в прошлый комит
```bash
ivan@ivan-ThinkPad-X395:~$ ansible-lint site.yml 
yaml: trailing spaces (trailing-spaces)
site.yml:70
```
и добавил ожидание
```bash
    - name: Pause for 10 seconds.
      ansible.builtin.pause:
        seconds: 10
```
```bash
ivan@ivan-ThinkPad-X395:~$ ansible-lint site.yml 
WARNING: PATH altered to include /usr/bin
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```

- Задание 6
```bash
ivan@ivan-ThinkPad-X395:~$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-client-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-client-22.3.3.44.rpm' found on system"]}

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   
```

- Задание 7

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-playbook -i inventory/prod.yml site.yml --diff
PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "ivan", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "ivan", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Start clickhouse-server] ****************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Create database] ************************************************************************************************************************************************************************************
changed: [clickhouse-01]

RUNNING HANDLER [Start clickhouse service] ****************************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download Vector] ************************************************************************************************************************************************************************************
changed: [vector-01]

TASK [Install Vector] *************************************************************************************************************************************************************************************
changed: [vector-01]

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
- Задание 8

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "ivan", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "ivan", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Start clickhouse-server] ****************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Download Vector] ************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install Vector] *************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Задание 9

[Ссылка на README](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-02-playbook)

- Задание 10

[Ссылка на измененный playbook](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-02-playbook/playbook)
