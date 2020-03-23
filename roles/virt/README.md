# About

These are the virtualization roles.

---

# Folder structure

```
roles/virt
└── ovirt
    ├── auth
    ├── get_ca
    └── networks
```

### ovirt/get_ca

Creates and deletes the ovirt certificate authority file.

Vars used: `playbook_dir`,`ovirt_engine_endpoint`

States: `present`,`absent`

### ovirt/auth

Creates and deletes ovirt authentication.

Vars used:

| Var name              | Purpose              | Defined where              |
| --------------------- | -------------------- | -------------------------- |
| ovirt_engine_endpoint | URL for Ovirt        | group_vars/all/main.yml    |
| playbook_dir          | Lookup ovirt.ca file | Magic variable             |
| ovirt_username        | Username             | group_vars/all/secrets.yml |
| ovirt_password        | Password             | group_vars/all/secrets.yml |

States: `present`,`absent`

Returns: `ovirt_auth`

### ovirt/networks

Sets up and destroys networks for ovirt. 

Loops through the variable `networks` , only creating networks with an assigned vlan_id. After they are created, the networks are assigned to the interface that does not contain the management subnet.

Vars used: `ovirt_auth`,`ovirt_datacenter`, `networks`,`ovirt_cluster_name`

| Var name         | Purpose                 | Defined where              |
| ---------------- | ----------------------- | -------------------------- |
| ovirt_auth       | Ovirt Authentication    | From auth                  |
| ovirt_datacenter | Setting Datacenter      | group_vars/all/ovirt.yml   |
| networks         | List of networks        | group_vars/all/network.yml |
| vm_interface     | Eth interface for hosts | group_vars/ovirt.yml       |

### ovirt/import_template

Imports and removes a template in ovirt from the OpenStack glance image repository. This is named ovirt-image-repository.

Vars used:

| Var name                    | Purpose                                    | Defined where            |
| --------------------------- | ------------------------------------------ | ------------------------ |
| ovirt_auth                  | Ovirt Authentication                       | From auth                |
| ovirt_base_template_name    | Name of template to create                 | Defaults of role         |
| ovirt_template_import_image | Name of template from glance to import     | Defaults of role         |
| ovirt_storage_domain        | The storage domain to save the template to | group_vars/all/ovirt.yml |
| ovirt_cluster_name          | The Cluster to save the template to        | group_vars/all/ovirt.yml |

States: `present`,`absent`



### ovirt/modify_template

Imports a template and performs modifications on it, before saving it as a template.

By default, this will install the following packages:

- vim

- htop

- qemu-guest-agent

- freeipa-client

Default vars:

| Var Name                        | Purpose                                           | Type    | Default                                                |
| ------------------------------- | ------------------------------------------------- | ------- | ------------------------------------------------------ |
| ovirt_base_template_name        | Name of template to load and then save to.        | string  | "base_image"                                           |
| ovirt_nic_network               | The name of the network to create the template on | string  | "virtual"                                              |
| ovirt_template_packages         | List of packages to install onto template         | list    | vim,htop,qemu-guest-agent,freeipa-client,dnf-automatic |
| ovirt_template_enabled_services | List of systemd units to enable at boot           | list    | qemu-guest-agent,dnf-automatic-install.timer           |
| ovirt_template_selinux_disabled | Disable selinux                                   | Boolean | True                                                   |
| ovirt_template_upgrade_all      | Upgrade all packages                              | Boolean | True                                                   |

Vars used:

| Var name           | Purpose                 | Defined where            |
| ------------------ | ----------------------- | ------------------------ |
| ovirt_auth         | Ovirt Authentication    | From auth                |
| ovirt_cluster_name | The Cluster to work on. | group_vars/all/ovirt.yml |

After this has completed, it will create a subversion of the template with all the intalled packages and modifications.








