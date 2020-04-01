# About

These are the virtualization roles.

---

# Folder structure

```
roles/virt
└── ovirt
    ├── auth
    ├── get_ca
    ├── import_template
    ├── mac_info
    ├── modify_template
    ├── networks
    └── virtual_machine
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

If `ovirt_template_extra_commands` is defined (as a list), these will be run in the `runcmd` portion of cloud-init.

If `ovirt_template_extra_repos` is defined, with a specific structure (see below), it will add the repo to the cloud-init as a yum-repo.

```yaml
ovirt_template_extra_repos:
    REPONAME:
        url: "https://google.com"
        name: "google-example"
        gpgkey: "https://google.com/gpgkey"
```



By default, this will install the following packages:

- vim

- htop

- qemu-guest-agent

- freeipa-client

Default vars:

| Var Name                        | Purpose                                           | Type    | Default                                                |
| ------------------------------- | ------------------------------------------------- | ------- | ------------------------------------------------------ |
| ovirt_base_template_name        | Name of template to load                          | string  | "base_image"                                           |
| ovirt_base_template_savename    | Name of template to save as.                      | string  | "base_image"                                           |
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

### ovirt/virtual_machine

Role to handle the creation, deletion, starting and stopping of virtual machines.

Unless specified otherwise, virtual machine will be created from the template name defined with `ovirt_base_template_name`. 

This will create a virtual machine and use the first user:ssh_key pair in the `ssh_keys` list to initiate the first user. The root account will not be given an ssh key or password.

If you need to pass any additional arguements to cloud-init at boot; you can use the variable `ovirt_vm_cloud_init_extras` when running this role.

States: `present`,`absent`,`started`,`stopped`

Vars used:

| Var name           | Purpose                   | Defined where               |
| ------------------ | ------------------------- | --------------------------- |
| ovirt_auth         | Ovirt Authentication      | From auth                   |
| inventory_hostname | Virtual machine name      | magic var                   |
| ovirt_cluster_name | Cluster to create vm in   | group_vars/all/ovirt.yml    |
| ssh_keys           | Add an initial admin user | group_vars/all/ssh_keys.yml |

Default vars:

| Var Name                 | Purpose                                                           | Type   | Default      |
| ------------------------ | ----------------------------------------------------------------- | ------ | ------------ |
| ovirt_base_template_name | Name of template to create vm from                                | string | "base_image" |
| ovirt_vm_cores           | The number of cores to create for the vm                          | int    | "4"          |
| ovirt_vm_ram             | The amount of ram to create for the virtual machine (MB)          | int    | 2048         |
| ovirt_vm_admin_user      | User and ssh keypair to make as first user                        | string | oxide        |
| ovirt_vm_networks        | Networks to create on host (titles of networks in `networks` var) | list   | virtual      |
| ovirt_vm_ha              | Enable High availability on vm                                    | string | no           |

Returned vars: `less`,`than`,`three`

Returned vars:

| Var name         | Purpose       | Type            |
| ---------------- | ------------- | --------------- |
| More than 3 vars | Why it's used | Where it's used |
