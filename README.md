[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-samba.svg?branch=20.04)](https://travis-ci.org/open-io/ansible-role-openio-samba)
# Ansible role `samba`

An Ansible role for SAMBA and CTDB.

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_samba_ctdb` | `false` | Enable CTDB |
| `openio_samba_ctdb_manages_nfs` | `"no"` | CTDB manage NFS |
| `openio_samba_ctdb_manages_samba` | `"yes"` | CTDB manage SAMBA |
| `openio_samba_ctdb_manages_winbind` | `"yes"` | CTDB manage WINBIND |
| `openio_samba_ctdb_nodes_list` | `[]` | CTDB hosts addresses |
| `openio_samba_ctdb_recovery_lock` | `/some/place/on/shared/storage/ctdb/lock` | CTDB lock directory |
| `openio_samba_ctdb_service_enabled` | `false` | CTDB service at boot |
| `openio_samba_ctdb_service_state` | `stopped` | CTDB service state |
| `openio_samba_mountpoints` | `[]` | List of mounts |
| `openio_samba_server_name` | `csmb-server` | SAMBA server name |
| `openio_samba_service_enabled` | `false` | Enable SAMBA service on boot |
| `openio_samba_service_state` | `stopped` | SAMBA service state |


## Active Directory
### What set in `openio_samba_active_directory` ?

```yaml
openio_samba_active_directory:
  nameserver_address: 172.31.130.54
  domain_name: "test.oio"
  workgroup: "TEST-OIO"
  admin: "Administrator"
  password: "Ojjahdo1!"
  samba_address: "172.31.130.29"
  id_range: "3000-7999"
```

### How to find informations ?
```console
C:\Users\openio>Net Config Workstation
Computer name                        \\WIN2016
Full Computer name                   win2016.cnci.oio
User name                            openio

Workstation active on
        NetBT_Tcpip_{2E871AAA-CCF8-4A79-902F-675ADDE3FD43} (FA163E1A3663)
        NetBT_Tcpip_{B8A56940-05EC-428F-BA5F-8C447B7BF63D} (FA163EF5FFAE)

Software version                     Windows Server 2016 Standard Evaluation

Workstation domain                   CNCIAD     <- WORKGROUP
Workstation Domain DNS Name          cnci.oio   <- domain
Logon domain                         CNCIAD

COM Open Timeout (sec)               0
COM Send Count (byte)                16
COM Send Timeout (msec)              250
The command completed successfully.
```

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  become: true

  roles:
    - role: samba
      openio_samba_service_state: started
      openio_samba_service_enabled: true
      openio_samba_ctdb: true
      openio_samba_ctdb_service_state: stopped
      openio_samba_ctdb_service_enabled: false
      openio_samba_ctdb_recovery_lock: /tmp/ctdb/lock
      openio_samba_ctdb_manages_samba: "yes"
      openio_samba_ctdb_manages_winbind: "yes"
      openio_samba_ctdb_manages_nfs: "no"
      openio_samba_ctdb_nodes_list:
        - 10.0.0.1
        - 10.0.0.2
      openio_samba_mountpoints:
        - comment: Samba
          ? "ea support"
          : "yes"
          export_name: plop
          path: /tmp/foo
          public: "yes"
          ? "read only"
          : "no"
          ? "vfs objects"
          : "catia fruit streams_xattr"
          writeable: "yes"
```


```ini
[all]
node1 ansible_host=10.0.0.1
```

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

GNU AFFERO GENERAL PUBLIC LICENSE, Version 3

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
- [Romain ACCIARI](https://github.com/racciari) (maintainer)
