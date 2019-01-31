[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-samba.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-samba)
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
| `openio_samba_service_enabled` | `false` | SAMBA service at boot |
| `openio_samba_service_state` | `stopped` | SAMBA service state |

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
