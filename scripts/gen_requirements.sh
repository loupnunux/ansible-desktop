#!/bin/bash

rm requirements.yml
echo -e "# Install a role at a specific commit from GitLab#\n" > requirements.yml
for i in $(ls roles); do
  if [ $i != README.md ]; then
cat <<EOF >>requirements.yml
- name: $i
  src: https://github.com/loupnunux/ansible-desktop-roles-$i.git
  scm: git
  version: master

EOF
  fi
done

