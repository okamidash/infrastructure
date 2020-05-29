# About

These are cloud related roles. These roles are typically used to setup things like virtual machines on other providers.

---

```
roles/cloud
├── cloudflare
└── digitalocean
```

### cloudflare

Sets up DNS records on cloudflare.

Takes an array in the following format.

```
cloudflare_dns_records:
    - zone: oxide.one (required)
      record: blackbird (optional, default '@')
      type: "A" (optional, default 'A')
      ttl: 120 (optional, default 120)
      value: 127.0.0.1 (required)            
            
```

States: `present`, `absent`

Vars used:

| Var name          | Purpose                        | Defined where              |
| ----------------- | ------------------------------ | -------------------------- |
| cloudflare_apikey | For calling the cloudflare API | group_vars/all/secrets.yml |
| cloudflare_email  | Email used to call the CF API  | group_vars/all/secrets.yml |

States: `present`,`absent`

### digitalocean

Creates and deletes virtual machines.

Optionally sets a DNS record pointing to the virtual machine after it's created.

The DNS record created will be an A and AAAA record, constituting of the short hostname with the domain appended on the end.

Vars used:

| Var name             | Purpose                                 | Optional | Defined where              |
| -------------------- | --------------------------------------- | -------- | -------------------------- |
| digitalocean_apikey  | For calling the digitalocean API        | no       | group_vars/all/secrets.yml |
| digitalocean_sshkey  | SSH Key ID to init the vm with          | no       | group_vars/all/secrets.yml |
| digitalocean_vm_tags | Tags to create the virtual machine with | yes      |                            |

Defaults:

| Var Name                     | Purpose                                                   | Type   | Default       |
| ---------------------------- | --------------------------------------------------------- | ------ | ------------- |
| digitalocean_image           | Specify the image to make a VM from                       | sring  | fedora-31-x64 |
| digitalocean_size            | Specify the droplet size to create                        | string | s-1vcpu-3gb   |
| digitalocean_region          | The region to create the VM in                            | string | lon1          |
| digitalocean_call_cloudflare | Whether to call cloudflare on creation of virtual machine | bool   | true          |

This returns the variable `droplet_info` if you care to use it.
