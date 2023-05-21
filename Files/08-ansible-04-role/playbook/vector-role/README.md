Vector-Role
=========

Install and setting up Vector

Requirements
------------

- Yandex cloud was used to create the environment

Role Variables
--------------

|Name|Description|
|-----|-----|
| vector_version | define version Vector

Dependencies
------------

No

Example Playbook
----------------

Set server group in [Inventory](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/inventory/prod.yml)
for [site.ymp](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/site.yml) for roles vector-role

Exapmle:
```bash
vector:
  hosts:
    vector-01:
      ansible_host: 84.201.157.43
```

License
-------

MIT

Author Information
------------------

Created by [Ivan Shumbasov](https://github.com/northsilver)

[Vector](https://vector.dev)