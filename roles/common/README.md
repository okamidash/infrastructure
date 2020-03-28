# About

These are common roles. Typically not associated with an action

---

```
roles/common
├── acme
└── docker
```

### acme

This role creates a user and gets ssl certificates via Cloudflare and Letsencrypt. By running this role with the `present` state, it will create a user, download and install acme.sh and finally request certificates.

Certs will be installed into the user's homedir under /certs

Please note that when running under `absent` state. It will Delete the user and remove their home directory.

It is required that the first item in the list for `acme_domains` to be `{{ inventory_hostname }}` otherwise ansible will be unable to find them.

States: `present`,`absent`,`renew`

Vars used:

| Var name          | Purpose                         | Defined where              |
| ----------------- | ------------------------------- | -------------------------- |
| cloudflare_email  | Email to use for Cloudflare API | group_vars/all/secrets.yml |
| cloudflare_apikey | Key to use for Cloudflare API   | group_vars/all/secrets.yml |

Defaults:

| Var Name                  | Purpose                                                                   | Type   | Default                  |
| ------------------------- | ------------------------------------------------------------------------- | ------ | ------------------------ |
| acme_default_user         | User under which acme.sh will be installed for, along with cert location. | string | web                      |
| acme_default_user_homedir | Default home dir location for the acme default user                       | string | /home/web                |
| acme_domains              | List of domains to request certificates from                              | list   | {{ inventory_hostname_}} |

### docker

Installs Docker onto a Fedora based system. 

The machine will need to be restarted for this to work properly, as Fedora 31 currently requires a CGROUP modification to work.

States: `present`,`absent`

### nfs_mounts

Configures and sets up NFS mounts for a Fedora based system.

Reads the array `nfs_mounts` specified in group_vars/all/nfs_mounts.yml and configures mounts under `default_storage_mountpoint/nfs`.

If `nfs_mount` is not specified, this role will attempt to mount all nfs mounts in the array.

States: `present`,`absent`

Vars used:

| Var name   | Purpose                                | Defined where              |
| ---------- | -------------------------------------- | -------------------------- |
| nfs_mounts | Which mounts to setup and configure    | group_vars/all/secrets.yml |
| nfs_mount  | If specified, only mount this mount(s) | N/A                        |

Defaults:

| Var Name                   | Purpose                                                           | Type   | Default                              |
| -------------------------- | ----------------------------------------------------------------- | ------ | ------------------------------------ |
| default_storage_mountpoint | The directory under which the storage mountpoints will be created | string | /storage                             |
| nfs_mount_options          | The default NFS mounting options                                  | string | defaults,timeo=900,retrans=5,_netdev |




