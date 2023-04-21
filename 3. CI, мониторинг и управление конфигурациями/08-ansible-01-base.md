- Задание 1

Равно 12

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-playbook site.yml -i inventory/test.yml

PLAY [Print os facts] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Print OS] *******************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ************************************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Задание 2

Поменял в файле \playbook\group_vars\all\examp.yml

```bash
TASK [Print fact] *****************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
```
- Задание 3

ОК

- Задание 4

```bash
ivan@ivan-ThinkPad-X395:~$ sudo ansible-playbook site.yml -i inventory/prod.yml

PLAY [Print os facts] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *******************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Задание 5

Сделал два каталога и поменял в файлах у каждого соответственно

```bash
ivan@ivan-ThinkPad-X395:~$ cat group_vars/{deb,el}/*
---
  some_fact: "deb default fact"
---
  some_fact: "el default fact"
```

- Задание 6

```bash
ivan@ivan-ThinkPad-X395:~$ sudo ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Print os facts] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *******************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Задание 7

```bash
ivan@ivan-ThinkPad-X395:~$ cat group_vars/{deb,el}/*
$ANSIBLE_VAULT;1.1;AES256
31356461636633396565626262616165656335383961633735386532306262346130643966633166
6239613263313639356563623462623030613030393432370a636364303734656430623634656236
33316538393136656139326331356234363739383062663036616165323036373730306661366430
3062643330313765660a323664666563623034306633353039633337383863393733616436316633
66326439336564313765373966373063353835306330346662356635333232316463383466636561
3936313663313161396531633762383533356131306639316462
$ANSIBLE_VAULT;1.1;AES256
38623732346333326236613464353464313739666266336237613231643963663036333363656431
3030623061303137393866316363643564383133663261310a326534643364663932343462313461
33643530616430343562363838386364623666313130303831303937313962383135366337666339
3837613565633838640a316336623239613831666434376633333038653433636530393561353838
39326465353563643136333536383837323661643936323838363437396339643135333238316430
6236623164613234303930333530653536636239656561633732
```

- Задание 8

```bash
ivan@ivan-ThinkPad-X395:~$ sudo ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *******************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Задание 9

Можно посмотреть типы в доке и выбрать нужные 
```bash
Choose which plugin type (defaults to "module"). Available plugin types are : ('become', 'cache', 'callback', 'cliconf', 'connection', 'httpapi', 'inventory', 'lookup',
                        'netconf', 'shell', 'vars', 'module', 'strategy', 'test', 'filter', 'role', 'keyword')
```
Но основным наверное будет тип connection т.к. содержит основные способы подключения/управления

```bash
ivan@ivan-ThinkPad-X395:~$ ansible-doc -t 'connection' -l
ansible.builtin.local          execute on controller                                                                                                                                                  
ansible.builtin.paramiko_ssh   Run tasks via python ssh (paramiko)                                                                                                                                    
ansible.builtin.psrp           Run tasks over Microsoft PowerShell Remoting Protocol                                                                                                                  
ansible.builtin.ssh            connect via SSH client binary                                                                                                                                          
ansible.builtin.winrm          Run tasks over Microsoft's WinRM                                                                                                                                       
ansible.netcommon.grpc         Provides a persistent connection using the gRPC protocol                                                                                                               
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                                                                                                                       
ansible.netcommon.libssh       Run tasks using libssh for ssh connection                                                                                                                              
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol                                                                                                            
ansible.netcommon.network_cli  Use network_cli to run command on network appliances                                                                                                                   
ansible.netcommon.persistent   Use a persistent unix socket for connection                                                                                                                            
community.aws.aws_ssm          execute via AWS Systems Manager                                                                                                                                        
community.docker.docker        Run tasks in docker containers                                                                                                                                         
community.docker.docker_api    Run tasks in docker containers                                                                                                                                         
community.docker.nsenter       execute on host running controller container                                                                                                                           
community.general.chroot       Interact with local chroot                                                                                                                                             
community.general.funcd        Use funcd to connect to target                                                                                                                                         
community.general.iocage       Run tasks in iocage jails                                                                                                                                              
community.general.jail         Run tasks in jails                                                                                                                                                     
community.general.lxc          Run tasks in lxc containers via lxc python library                                                                                                                     
community.general.lxd          Run tasks in lxc containers via lxc CLI                                                                                                                                
community.general.qubes        Interact with an existing QubesOS AppVM                                                                                                                                
community.general.saltstack    Allow ansible to piggyback on salt minions                                                                                                                             
community.general.zone         Run tasks in a zone instance                                                                                                                                           
community.kubernetes.kubectl   Execute tasks in pods running on Kubernetes                                                                                                                            
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                                                                                                                                
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                                                                                                                             
community.okd.oc               Execute tasks in pods running on OpenShift                                                                                                                             
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                                                                                                                             
containers.podman.buildah      Interact with an existing buildah container                                                                                                                            
containers.podman.podman       Interact with an existing podman container                                                                                                                             
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes 
```

- Задание 10

Внес изменения в prod.yml

```bash
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```

- Задание 11

```bash
ivan@ivan-ThinkPad-X395:~$ sudo ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
[sudo] password for ivan: 
Vault password: 

PLAY [Print os facts] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [localhost]
ok: [centos7]
ok: [ubuntu]

TASK [Print OS] *******************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *****************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Задание 12

[Ссылка на измененный playbook](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/08-ansible-01-base/playbook)