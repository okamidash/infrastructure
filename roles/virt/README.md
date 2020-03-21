# About

These are the virtualization roles.

---

# Folder structure

```
roles/virt
├── ovirt
│   └── get_ca
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


