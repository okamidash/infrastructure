# Roles

These are my roles within my infrastructure. As it currently stands, there are 4 Categories of roles. App, Common, Net and Virt.

---

# Folder Structure

```
roles/
├── app
│   └── freeipa
├── common
│   └── acme
├── net
│   └── vyos
└── virt
    └── ovirt
```

### App

Application related roles. These are the roles to deploy applications. Commonly associated with the virt moduels.

### Common

Roles that do not fit within a specific 'category'. 

### Net

Network related modules for setting up network architecture (wireguard, vyos, DNS etc)

### Virt

Virtualization related modules for setting up virt stuff. 
