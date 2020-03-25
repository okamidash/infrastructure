# Network Related Roles

This folder covers the roles related to network operations. Primarily this will be vyos, but stuff like modifying DNS records can also exist here unless it is application specific.

---

# FOLDER STRUCTURE

```
roles/net
└── vyos
    ├── dhcp
    ├── dns
    ├── init
    ├── phys_network
    └── static_dhcp
```

### vyos/dhcp

Sets and deletes basic DHCP rules. Does not cover Dynamic DNS. By default this will configure the dns server as the gateway. Use in conjunction with vyos/dns.

States: `present`,`absent`

Vars used:

| Var name           | Purpose                                                     | Defined where               |
| ------------------ | ----------------------------------------------------------- | --------------------------- |
| networks           | Iterates through the networks as a list                     | group_vars/all/networks.yml |
| group_names        | Determine if the network is managed by a specific host      | magic var                   |
| networks.gateway   | To set the network and gateway for DHCP                     | group_vars/all/networks.yml |
| dhcp_range_start   | Get the start of DHCP range                                 | group_vars/all/networks.yml |
| dhcp_range_end     | Get the end of DHCP range                                   | group_vars/all/networks.yml |
| networks.subdomain | To set the subdomain for a specific network                 | group_vars/all/networks.yml |
| domain             | To set the domain that a subdomain is part of, in a network | group_vars/all/networks.yml |

### vyos/dns

Sets the DNS forwarding settings for vyos. Does not deal with Dynamic dns. Only creates a DNS service that forwards requests to the upstream dns server.

Vars used:

| Var name   | Purpose                                          | Defined where               |
| ---------- | ------------------------------------------------ | --------------------------- |
| networks   | Find networks in scope to create DNS service on. | group_vars/all/networks.yml |
| dns_server | Sets the DNS server to forward dns requests to   | group_vars/all/networks.yml |

States: `present`,`absent`

### vyos/init

Initialises the system. Sets the hostname from `inventory_hostname` and sets the domain name from `domain`. Iterates through a list of users in `ssh_keys` and adds them to authenticated users.

Vars used: `inventory_hostname`, `domain`,`ssh_keys`

States: `present`,`absent`

### vyos/phys_network

Creates Virtual interfaces for vlans. Checks if the network is in scope for the router by comparing the `managed_by` section with the `group_names` magic var. 

States: `present`,`absent`

Vars used: `networks`,`group_names`,`lan_interface`,`wan_interface`

### vyos/static_dhcp

Creates static DHCP reservations using the `static_mappings` of each network.

Expects a MAC address to exist for each host or it will not create the mapping.

States: `present,``absent`.






