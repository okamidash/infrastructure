# About

These are common roles. Typically not associated with an action

---

```
roles/common
└── acme
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
