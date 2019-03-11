#!/bin/bash

scripts_rep=$(dirname $0)


f_role() {
  cd $scripts_rep
  cd ../roles

  for i in $(grep 'src: ' ../requirements.yml | awk -F'src: ' '{print $2}'); do
    name=$(echo $i | awk -F'-' '{print $4}'| awk -F'.' '{print $1}')
    if [ ! -d $name ]; then
      echo "### Clone the repository $i"
      git clone $i $name
    else
      echo "### Pull the repository $i"
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

