
> **Remove this part after a clone**

```sh
git clone git@github.com:open-io/ansible-role-openio-skeleton.git ROLENAME
cd ROLENAME
grep -r -E '\b[A-Z]+\b' --exclude=LICENSE *
find $PWD -type f -print0 | xargs -0 sed -i -e 's@ROLENAME@trueName@g'
git remote -v
git remote set-url origin git@github.com:open-io/ansible-role-openio-ROLENAME.git

vi meta/main.yml # change purpose and tags
vi README.md
git worktree add docker-tests origin/docker-tests
```

It is **required** to:
  - Change the author
  - Choose one or many maintainers
  - Change the purpose
  - Change the rolename
  - Inform the responsibilities of this role (README)
  - Feed the `Role Variables` table (README)
  - Add one or more examples of playbook (README)
  - Activate tests in Travis CI
  - Write functional tests in the branch `docker-tests`

It is **recommended** to:
  - Setup tests on your local machine (see below)

> Use the following instructions to setup your testing environment
> (make sure virtualenv2 is installed)
>
```sh
virtualenv2 env && source env/bin/activate
pip install yamllint ansible-lint
# Run tests run before each commit
export HOOK=".git/hooks/prepare-commit-msg"
if [ ! -f "$HOOK" ] ; then echo "#\!/bin/sh" > "$HOOK" && chmod +x "$HOOK"; fi
cat << \EOF >> .git/hooks/prepare-commit-msg
cmds=("ansible-lint . -x ANSIBLE0016" "yamllint -c .yamllint .")
for cmd in "${cmds[@]}"; do
  echo "Running ${cmd%% *}"
  cmd_out="$($cmd)"
  echo -n "${cmd_out}"
  if [ "$cmd_out" ]; then
      echo -e "\nRejecting commit: ${cmd%% *} returned errors"
      exit 1
  fi
done
EOF
```

#### `Role Variables` table
```sh
for i in $(grep -E "^openio_" defaults/main.yml |cut -d':' -f1| sort); do echo '|' '`'$i'`'' | `'$(grep $i defaults/main.yml|cut -d: -f2|sed -e "s/^ //")'` | ... |'; done
```

-----REMOVE--THE---8<-----PREVIOUS---PART------
__

[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-ROLENAME.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-ROLENAME)
# Ansible role `ROLENAME`

An Ansible role for PURPOSE. Specifically, the responsibilities of this role are to:

-

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_ROLENAME_...` | `...`   | ...              |

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  gather_facts: true
  become: true
  roles:
    - role: ROLENAME
```


```ini
[all]
node1 ansible_host=192.168.1.173
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
- [Vincent LEGOLL](https://github.com/vincent-legoll) (maintainer)
- [Sebastien LAPIERRE](https://github.com/sebastienlapierre) (maintainer)
- [Geoffrey TIEN](https://github.com/GeoffreyTien) (maintainer)
