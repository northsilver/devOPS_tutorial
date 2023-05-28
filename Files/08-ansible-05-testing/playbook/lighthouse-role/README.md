Lighthouse-Role
=========

Install and setting up Lighthouse

For launch also will be install `nginx`

Requirements
------------

- Yandex cloud was used to create the environment

Role Variables
--------------

No user variables

Dependencies
------------

No

Example Playbook
----------------

Set server group in [Inventory](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/inventory/prod.yml)
for [site.ymp](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-04-role/playbook/site.yml) for roles lighthouse-role

Exapmle:
```bash
lighthouse:
  hosts:
    lighthouse-01:
      ansible_host: 84.201.157.43
```

License
-------

MIT

Author Information
------------------

Created by [Ivan Shumbasov](https://github.com/northsilver)

- [Nginx](https://nginx.org/)
- [Lighthouse](https://github.com/VKCOM/lighthouse)
