### Molecule

- Задание 1

```bash
ivan@ivan-ThinkPad-X395:~$ molecule test -s centos_7
---
dependency:
  name: galaxy
driver:
  name: docker
  options:
    D: true
    vv: true
lint: 'yamllint .

  ansible-lint

  flake8

  '
platforms:
  - capabilities:
      - SYS_ADMIN
    command: /usr/sbin/init
    dockerfile: ../resources/Dockerfile.j2
    env:
      ANSIBLE_USER: ansible
      DEPLOY_GROUP: deployer
      SUDO_GROUP: wheel
      container: docker
    image: centos:7
    name: centos_7
    privileged: true
    tmpfs:
      - /run
      - /tmp
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup
provisioner:
  inventory:
    links:
      group_vars: ../resources/inventory/group_vars/
      host_vars: ../resources/inventory/host_vars/
      hosts: ../resources/inventory/hosts.yml
  name: ansible
  options:
    D: true
    vv: true
  playbooks:
    converge: ../resources/playbooks/converge.yml
verifier:
  name: ansible
  playbooks:
    verify: ../resources/tests/verify.yml

CRITICAL Failed to pre-validate.
```

- Задание 2
```bash
ivan@ivan-ThinkPad-X395:~$ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/molecule/default successfully.
```

- Задание 3

[Molecule.yml](https://github.com/northsilver/devOPS_tutorial/blob/v.0.1.1/Files/08-ansible-05-testing/playbook/vector-role/molecule/default/molecule.yml)

- Задание 4

[Verify.yml](https://github.com/northsilver/devOPS_tutorial/blob/v.0.1.1/Files/08-ansible-05-testing/playbook/vector-role/molecule/default/verify.yml)

- Задание 5

```bash
ivan@ivan-ThinkPad-X395:~$ molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/ivan/.cache/ansible-compat/f5bcd7/modules:/home/ivan/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/ivan/.cache/ansible-compat/f5bcd7/collections:/home/ivan/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/ivan/.cache/ansible-compat/f5bcd7/roles:/home/ivan/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos_8)
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']})
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8) 
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest) 
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '424081161608.76615', 'results_file': '/home/ivan/.ansible_async/424081161608.76615', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '688038123970.76648', 'results_file': '/home/ivan/.ansible_async/688038123970.76648', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
fatal: [ubuntu_latest]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector': b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
fatal: [centos_8]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector': b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring
...ignoring

TASK [vector-role : Create directory vector] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Get vector distrib] ****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Unarchive vector] ******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector-role : Create a symbolic link] ************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Mkdir vector data] *****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Vector config create] **************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Create vector unit flie] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

RUNNING HANDLER [vector-role : Restart Vector] *********************************
changed: [ubuntu_latest]
changed: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   
ubuntu_latest              : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector-role : Create directory vector] ***********************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Get vector distrib] ****************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Unarchive vector] ******************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Create a symbolic link] ************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Mkdir vector data] *****************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Vector config create] **************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector-role : Create vector unit flie] ***********************************
skipping: [centos_8]
skipping: [ubuntu_latest]

PLAY RECAP *********************************************************************
centos_8                   : ok=2    changed=1    unreachable=0    failed=0    skipped=7    rescued=0    ignored=0
ubuntu_latest              : ok=2    changed=1    unreachable=0    failed=0    skipped=7    rescued=0    ignored=0

CRITICAL Idempotence test failed because of the following tasks:
*  => vector-role : Get Vector version
*  => vector-role : Get Vector version
WARNING  An error occurred during the test sequence action: 'idempotence'. Cleaning up.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos_8)
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

- Задание 6

[v.0.1.1](https://github.com/northsilver/devOPS_tutorial/tree/v.0.1.1/Files/08-ansible-05-testing/playbook/vector-role)

### Tox

- Задание 1

OK

- Задание 2

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role$ docker run --privileged=True -v ./:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash
[root@b6b9834d45e3 vector-role]#
```

- Задание 3

```bash
[root@b6b9834d45e3 vector-role]# tox
py37-ansible210 create: /opt/vector-role/.tox/py37-ansible210
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.6.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.3.5,ruamel.yaml==0.17.28,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.6.2,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='375693179'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.6.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.3.5,ruamel.yaml==0.17.28,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.6.2,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='375693179'
py37-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible210 create: /opt/vector-role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.0,ansible-core==2.15.0,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,resolvelib==1.0.1,rich==13.3.5,ruamel.yaml==0.17.28,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.6.2,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='375693179'
py39-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible30 create: /opt/vector-role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==4.1.0,ansible-core==2.15.0,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,resolvelib==1.0.1,rich==13.3.5,ruamel.yaml==0.17.28,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.6.2,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='375693179'
py39-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
_________________________________________________________________________________________________ summary _________________________________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: commands failed
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
```

- Задание 4

```bash
ivan@ivan-ThinkPad-X395:~$ molecule test -s podman
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/ivan/.cache/ansible-compat/f5bcd7/modules:/home/ivan/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/ivan/.cache/ansible-compat/f5bcd7/collections:/home/ivan/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/ivan/.cache/ansible-compat/f5bcd7/roles:/home/ivan/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl', '/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '378928287490.119057', 'results_file': '/home/ivan/.ansible_async/378928287490.119057', 'changed': True, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role/systemctl3.py:/usr/bin/systemctl', '/home/ivan/proj/devOPS_tutorial/Files/08-ansible-05-testing/playbook/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="netology registry username: None specified") 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/aragast/netology:latest") 
skipping: [localhost]

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=netology)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/aragast/netology:latest) 
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="netology command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=netology: None specified) 
skipping: [localhost]

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=netology)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item=netology)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
fatal: [netology]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring

TASK [vector-role : Create directory vector] ***********************************
changed: [netology]

TASK [vector-role : Get vector distrib] ****************************************
changed: [netology]

TASK [vector-role : Unarchive vector] ******************************************
changed: [netology]

TASK [vector-role : Create a symbolic link] ************************************
changed: [netology]

TASK [vector-role : Mkdir vector data] *****************************************
changed: [netology]

TASK [vector-role : Vector config create] **************************************
changed: [netology]

TASK [vector-role : Create vector unit file] ***********************************
changed: [netology]

RUNNING HANDLER [vector-role : Restart Vector] *********************************
changed: [netology]

PLAY RECAP *********************************************************************
netology                   : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   

INFO     Running podman > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
changed: [netology]

TASK [vector-role : Create directory vector] ***********************************
skipping: [netology]

TASK [vector-role : Get vector distrib] ****************************************
skipping: [netology]

TASK [vector-role : Unarchive vector] ******************************************
skipping: [netology]

TASK [vector-role : Create a symbolic link] ************************************
skipping: [netology]

TASK [vector-role : Mkdir vector data] *****************************************
skipping: [netology]

TASK [vector-role : Vector config create] **************************************
skipping: [netology]

TASK [vector-role : Create vector unit flie] ***********************************
skipping: [netology]

PLAY RECAP *********************************************************************
netology                   : ok=2    changed=1    unreachable=0    failed=0    skipped=7    rescued=0    ignored=0

CRITICAL Idempotence test failed because of the following tasks:
*  => vector-role : Get Vector version
WARNING  An error occurred during the test sequence action: 'idempotence'. Cleaning up.
INFO     Running podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'volumes': ['/home/mask/Документы/Обучение/ansible/vector-role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j588546039233.262926', 'results_file': '/home/mask/.ansible_async/j588546039233.262926', 'changed': True, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'volumes': ['/home/mask/Документы/Обучение/ansible/vector-role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

- Задание 5

[Tox.ini](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-05-testing/playbook/vector-role/tox.ini)

- Задание 6

```bash
[root@5dd2b710850c vector-role]# tox
using tox.ini: /opt/vector-role/tox.ini (pid 131256)
using tox-3.25.0 from /usr/local/lib/python3.6/site-packages/tox/__init__.py (pid 131256)
py37-ansible210 cannot reuse: -r flag
py37-ansible210 recreate: /opt/vector-role/.tox/py37-ansible210
[131263] /opt/vector-role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.7 py37-ansible210 >py37-ansible210/log/py37-ansible210-0.log
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
[131270] /opt/vector-role$ /opt/vector-role/.tox/py37-ansible210/bin/python -m pip install -rtox-requirements.txt 'ansible<3.0' >.tox/py37-ansible210/log/py37-ansible210-1.log
write config to /opt/vector-role/.tox/py37-ansible210/.tox-config1 as '5936a1b960028407ab91e134153aed45ae70704a5c83c41d313f9c647b198b88 /usr/local/bin/python3.7\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible<3.0'
[131276] /opt/vector-role$ /opt/vector-role/.tox/py37-ansible210/bin/python -m pip freeze >.tox/py37-ansible210/log/py37-ansible210-2.log
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.6.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.30.0,rich==13.3.5,ruamel.yaml==0.17.26,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='3372460002'
py37-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
[131279] /opt/vector-role$ /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Guessed /opt/vector-role as project root directory
WARNING  Computed fully qualified role name of vector-role does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

INFO     Using /root/.cache/ansible-lint/b984a4/roles/vector-role symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '19404593915.131313', 'results_file': '/root/.ansible_async/19404593915.131313', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="netology registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/aragast/netology:latest") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=netology)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/aragast/netology:latest) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="netology command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=netology: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=netology)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=netology)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
fatal: [netology]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector': b'vector'", "rc": 2}
...ignoring

TASK [vector-role : Create directory vector] ***********************************
changed: [netology]

TASK [vector-role : Get vector distrib] ****************************************
changed: [netology]

TASK [vector-role : Unarchive vector] ******************************************
changed: [netology]

TASK [vector-role : Create a symbolic link] ************************************
changed: [netology]

TASK [vector-role : Mkdir vector data] *****************************************
changed: [netology]

TASK [vector-role : Vector config create] **************************************
changed: [netology]

TASK [vector-role : Create vector unit file] ***********************************
changed: [netology]

RUNNING HANDLER [vector-role : Restart Vector] *********************************
changed: [netology]

PLAY RECAP *********************************************************************
netology                   : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   

INFO     Running podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Get Vector version] ******************************************************
changed: [netology]

TASK [Assert Vector version] ***************************************************
ok: [netology] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [netology]

TASK [Assert Vector config] ****************************************************
ok: [netology] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [netology]

TASK [Assert Vector service] ***************************************************
ok: [netology] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
netology                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '198638191409.134835', 'results_file': '/root/.ansible_async/198638191409.134835', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py37-ansible30 cannot reuse: -r flag
py37-ansible30 recreate: /opt/vector-role/.tox/py37-ansible30
[134945] /opt/vector-role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.7 py37-ansible30 >py37-ansible30/log/py37-ansible30-0.log
py37-ansible30 installdeps: -rtox-requirements.txt, ansible>=2.12
[134952] /opt/vector-role$ /opt/vector-role/.tox/py37-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible>=2.12' >.tox/py37-ansible30/log/py37-ansible30-1.log
write config to /opt/vector-role/.tox/py37-ansible30/.tox-config1 as '5936a1b960028407ab91e134153aed45ae70704a5c83c41d313f9c647b198b88 /usr/local/bin/python3.7\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible>=2.12'
[134958] /opt/vector-role$ /opt/vector-role/.tox/py37-ansible30/bin/python -m pip freeze >.tox/py37-ansible30/log/py37-ansible30-2.log
py37-ansible30 installed: ansible==4.10.0,ansible-compat==1.0.0,ansible-core==2.11.12,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.6.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.30.0,resolvelib==0.5.4,rich==13.3.5,ruamel.yaml==0.17.26,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='3372460002'
py37-ansible30 run-test: commands[0] | molecule test -s podman --destroy always
[134961] /opt/vector-role$ /opt/vector-role/.tox/py37-ansible30/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Guessed /opt/vector-role as project root directory
WARNING  Computed fully qualified role name of vector-role does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

INFO     Using /root/.cache/ansible-lint/b984a4/roles/vector-role symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '199224588257.134999', 'results_file': '/root/.ansible_async/199224588257.134999', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="netology registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/aragast/netology:latest") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=netology)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/aragast/netology:latest) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="netology command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=netology: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=netology)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=netology)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
fatal: [netology]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring

TASK [vector-role : Create directory vector] ***********************************
changed: [netology]

TASK [vector-role : Get vector distrib] ****************************************
changed: [netology]

TASK [vector-role : Unarchive vector] ******************************************
changed: [netology]

TASK [vector-role : Create a symbolic link] ************************************
changed: [netology]

TASK [vector-role : Mkdir vector data] *****************************************
changed: [netology]

TASK [vector-role : Vector config create] **************************************
changed: [netology]

TASK [vector-role : Create vector unit file] ***********************************
changed: [netology]

RUNNING HANDLER [vector-role : Restart Vector] *********************************
changed: [netology]

PLAY RECAP *********************************************************************
netology                   : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   

INFO     Running podman > verify
INFO     Running Ansible Verifier
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Get Vector version] ******************************************************
changed: [netology]

TASK [Assert Vector version] ***************************************************
ok: [netology] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [netology]

TASK [Assert Vector config] ****************************************************
ok: [netology] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [netology]

TASK [Assert Vector service] ***************************************************
ok: [netology] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
netology                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running podman > destroy
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '375641531830.138476', 'results_file': '/root/.ansible_async/375641531830.138476', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py39-ansible210 cannot reuse: -r flag
py39-ansible210 recreate: /opt/vector-role/.tox/py39-ansible210
[138585] /opt/vector-role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.9 py39-ansible210 >py39-ansible210/log/py39-ansible210-0.log
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
[138592] /opt/vector-role$ /opt/vector-role/.tox/py39-ansible210/bin/python -m pip install -rtox-requirements.txt 'ansible<3.0' >.tox/py39-ansible210/log/py39-ansible210-1.log
write config to /opt/vector-role/.tox/py39-ansible210/.tox-config1 as 'b510db7918ae5db9e42709a71f141e64865d93035d115320ea8b760de8411d34 /usr/local/bin/python3.9\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible<3.0'
[138596] /opt/vector-role$ /opt/vector-role/.tox/py39-ansible210/bin/python -m pip freeze >.tox/py39-ansible210/log/py39-ansible210-2.log
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.0.4,ansible-core==2.15.0,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.30.0,resolvelib==1.0.1,rich==13.3.5,ruamel.yaml==0.17.26,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='3372460002'
py39-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
[138597] /opt/vector-role$ /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Guessed /opt/vector-role as project root directory
WARNING  Computed fully qualified role name of vector-role does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

INFO     Using /root/.cache/ansible-lint/b984a4/roles/vector-role symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1130, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1055, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1404, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 760, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/decorators.py", line 26, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 119, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 161, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 150, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/logger.py", line 187, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/destroy.py", line 107, in execute
    self._config.provisioner.destroy()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible.py", line 705, in destroy
    pb.execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible_playbook.py", line 106, in execute
    self._config.driver.sanity_checks()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule_podman/driver.py", line 212, in sanity_checks
    if runtime.version < Version("2.10.0") and runtime.config.ansible_pipelining:
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/runtime.py", line 295, in version
    self._version = parse_ansible_version(proc.stdout)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/config.py", line 42, in parse_ansible_version
    raise InvalidPrerequisiteError(msg)
ansible_compat.errors.InvalidPrerequisiteError: Unable to parse ansible cli version: ansible 2.10.17
  config file = /opt/vector-role/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible
  executable location = /opt/vector-role/.tox/py39-ansible210/bin/ansible
  python version = 3.9.2 (default, Jun 13 2022, 19:42:33) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]

Keep in mind that only 2.12 or newer are supported.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s podman --destroy always (exited with code 1)
py39-ansible30 cannot reuse: -r flag
py39-ansible30 recreate: /opt/vector-role/.tox/py39-ansible30
[138602] /opt/vector-role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.9 py39-ansible30 >py39-ansible30/log/py39-ansible30-0.log
py39-ansible30 installdeps: -rtox-requirements.txt, ansible>=2.12
[138609] /opt/vector-role$ /opt/vector-role/.tox/py39-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible>=2.12' >.tox/py39-ansible30/log/py39-ansible30-1.log
write config to /opt/vector-role/.tox/py39-ansible30/.tox-config1 as 'b510db7918ae5db9e42709a71f141e64865d93035d115320ea8b760de8411d34 /usr/local/bin/python3.9\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible>=2.12'
[138613] /opt/vector-role$ /opt/vector-role/.tox/py39-ansible30/bin/python -m pip freeze >.tox/py39-ansible30/log/py39-ansible30-2.log
py39-ansible30 installed: ansible==7.5.0,ansible-compat==4.0.4,ansible-core==2.14.5,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.5.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.1.0,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==40.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.2.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.1,paramiko==2.12.0,pathspec==0.11.1,pluggy==0.13.1,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.30.0,resolvelib==0.8.1,rich==13.3.5,ruamel.yaml==0.17.26,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==2.0.2,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='3372460002'
py39-ansible30 run-test: commands[0] | molecule test -s podman --destroy always
[138614] /opt/vector-role$ /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Guessed /opt/vector-role as project root directory
WARNING  Computed fully qualified role name of vector-role does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

INFO     Using /root/.cache/ansible-lint/b984a4/roles/vector-role symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j431694613705.138640', 'results_file': '/root/.ansible_async/j431694613705.138640', 'changed': True, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="netology registry username: None specified") 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/aragast/netology:latest") 
skipping: [localhost]

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=netology)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/aragast/netology:latest) 
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="netology command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=netology: None specified) 
skipping: [localhost]

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=netology)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=netology)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Get Vector version] ****************************************
fatal: [netology]: FAILED! => {"changed": false, "cmd": "vector --version", "failed_when_result": true, "msg": "[Errno 2] No such file or directory: b'vector'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
...ignoring

TASK [vector-role : Create directory vector] ***********************************
changed: [netology]

TASK [vector-role : Get vector distrib] ****************************************
changed: [netology]

TASK [vector-role : Unarchive vector] ******************************************
changed: [netology]

TASK [vector-role : Create a symbolic link] ************************************
changed: [netology]

TASK [vector-role : Mkdir vector data] *****************************************
changed: [netology]

TASK [vector-role : Vector config create] **************************************
changed: [netology]

TASK [vector-role : Create vector unit file] ***********************************
changed: [netology]

RUNNING HANDLER [vector-role : Restart Vector] *********************************
changed: [netology]

PLAY RECAP *********************************************************************
netology                   : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   

INFO     Running podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [netology]

TASK [Get Vector version] ******************************************************
changed: [netology]

TASK [Assert Vector version] ***************************************************
ok: [netology] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [netology]

TASK [Assert Vector config] ****************************************************
ok: [netology] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [netology]

TASK [Assert Vector service] ***************************************************
ok: [netology] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
netology                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j706541348205.142109', 'results_file': '/root/.ansible_async/j706541348205.142109', 'changed': True, 'item': {'image': 'docker.io/aragast/netology:latest', 'name': 'netology', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector-role/systemctl3.py:/usr/bin/systemctl', '/opt/vector-role:/opt/vector-role'], 'workdir': '/opt/vector_role'}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
______________________________________________________ summary ______________________________________________________
  py37-ansible210: commands succeeded
  py37-ansible30: commands succeeded
ERROR:   py39-ansible210: commands failed
  py39-ansible30: commands succeeded
```

- Задание 7

[v.0.2.1](https://github.com/northsilver/devOPS_tutorial/tree/v.0.2.1/Files/08-ansible-05-testing/playbook/vector-role)

