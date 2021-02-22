# Ansible role for install bareos client and add job to server

Your client and server should be defined in ```inventory``` file. Tested on ansible 2.9.3

### How to use

```sh
---
# Настройка клиента bareos
- hosts: webserver  
  gather_facts: yes
  become: true
  roles:
    - { role: 'bareos_install', bareos_mode: "client", }
# Настройка сервера bareos
- hosts: webserver  
  gather_facts: yes
  become: true  
  roles:
     - { role: "bareos_install", 
          delegate_to: "backups", 
          delegate_facts: true, 
          bareos_mode: "server", 
          backup_fileset: "/opt/docker",
          schedule_time: "14:00"}
```

