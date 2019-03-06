#!/bin/bash

rep='/opt/ansible/group_vars'
file="${rep}/all.yml"

id=$(id -u)
user=$(id -un)
password=$(sudo cat /etc/shadow | grep $user | cut -d: -f2)

mkdir -p $rep

cat <<EOF >$file
---

users:
  - username: ${user}
    name: ${user^}
    uid: ${id}
    shell: /usr/bin/zsh
    home: /home/${user}
    password: ${password}
    firefox_profile:
      - name: ${user}
    git_global:
      - "credential.helper store"
      - "http.sslVerify true"

laptop: false

EOF

