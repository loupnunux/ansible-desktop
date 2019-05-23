#!/bin/bash

rep='/opt/ansible/group_vars'
file="${rep}/all.yml"

id=$(id -u)
user=$(id -un)
password=$(sudo cat /etc/shadow | grep $user | cut -d: -f2)

mkdir -p $rep

cat <<EOF >$file
---

usergroups:
  - groupname: vboxusers
    gid: 127
    system: yes
  - groupname: ${user}
    gid: ${id}

users:
  - username: ${user}
    name: ${user^}
    uid: ${id}
    shell: /usr/bin/zsh
    home: /home/${user}
    password: ${password}
    groups: ${user},sudo,users,disk,vboxusers
    firefox_profile:
      - name: ${user}
    git_global:
      - "credential.helper store"
      - "http.sslVerify true"

laptop: false

EOF

