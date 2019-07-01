#!/bin/bash

scripts_rep="$( cd "$(dirname "$0")" ; pwd -P )"


f_role() {
  cd $scripts_rep
  cd ../roles

  for i in $(grep 'src: ' ../requirements.yml | awk -F'src: ' '{print $2}'); do
    name=$(echo $i | awk -F'-' '{print $4}'| awk -F'.' '{print $1}')
    if [ ! -d $name ]; then
      echo -e "### [\e[33mCLONE\e[0m] Repository $i"
      git clone $i $name
    else
      echo -e "### [\e[34mPULL\e[0m] Repository $i"
      (cd $name && git pull)
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
  f_role
fi

