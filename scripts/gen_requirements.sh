#!/bin/bash

scripts_rep="$( cd "$(dirname "$0")" ; pwd -P )"


f_requirement() {
  cd $scripts_rep
  cd ..

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
}



if [ $scripts_rep == '/opt/ansible/scripts' ]; then
  echo '################################'
  echo ''
  echo 'Do not work here : /opt/ansible/'
  echo ''
  echo '################################'
  exit 0
else
  f_requirement
fi

