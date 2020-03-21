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
