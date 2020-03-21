# About

This repo is my master repository for all of my Infrastructure.

---

# Folder Structure

```
├── files          - Folder for files
├── group_vars     
│   ├── all/       - Vars for all hosts.
│   └── vyos       - Vars for VyOS hosts
├── hosts.ini      - Inventory
├── host_vars      - Host specific vars
├── playbooks      - Playbooks
└── roles
    ├── app        - Application specific roles
    ├── net        - Network based operations
    └── virt       - Virtualization related

```

### Files

The files folder is where things like the ovirt certificate authority are stored.

### Group Vars/all

This folder contains all variables related to the entire estate. 

```
group_vars/all
├── main.yml        - Uncategorized/misc vars
├── network.yml     - Network related vars
├── secrets.yml     - Secrets
└── ssh_keys.yml    - SSH keys for users

```

**main.yml**

`domain` | (Currently `oxide.one`)



**network.yml**

`dns_server` | Sets the DNS server that all routers give out for dhcp

`dhcp_range_start` | The range that DHCP starts

 `dhcp_range_end` | The range that DHCP ends

`networks (array)` | An array with the following syntax

```yaml
networks:
    server: # The Name of the network
        gateway: 10.0.0.1/24 # The gateway and subnet
        managed_by: "wan"    # The group name of which router manages it
        subdomain: "dhcp"    # The subdomain of this network
        static_mappings:     # Array of static DHCP mappings
            blackbird.srv.oxide.one: # Name of device for mapping
                mac: "90:E2:BA:3F:27:D0" # Mac address for mapping
                ip:  "10.0.2.2"          # Ip address for mapping
```



**secrets.yml**

No vars defined in this file just yet.



**ssh_keys.yml**

Contains the var `ssh_keys` with the output of public keys assigned to a user in the format of `user:"key"`
