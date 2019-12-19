#!/bin/bash

scripts_rep="$( cd "$(dirname "$0")" ; pwd -P )"


f_requirement() {
  cd $scripts_rep
  cd ..

  rm requirements.yml
  echo -e "# Install a role at a specific commit from GitLab#\n" > requirements.yml
  for i in $(ls roles); do
    if [ $i != README.md ]; then
      url=$(cat roles/$i/.git/config | grep url | awk -F ' = ' '{print $2}')
cat <<EOF >>requirements.yml
- name: $i
  src: $url
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

