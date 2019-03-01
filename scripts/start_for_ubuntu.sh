#!/bin/bash

echo '###'
echo '### Install packages ###'
sudo apt-get install -y ansible git rsync ssh python

if [ ! -d /opt/ansible ]; then
  echo '###'
  echo '### Add directory ansible ###'
  cd /opt
  sudo mkdir -p /opt/ansible
  sudo chown $(id -un) /opt/ansible
  git clone git@vm-gitlab-01:desktop-ansible/ansible.git ansible
fi

echo '###'
echo '### Add ansible role ###'
cd /opt/ansible
git pull
ansible-galaxy install -f -r requirements.yml

if [ ! -f group_vars/all.yml ]; then
  echo '###'
  echo '### Generate group_vars ###'
  ./scripts/gen_groupvar.sh
fi

echo ''
echo '###################################################################################'
echo ''
echo 'Verifier les informations fournies dans le fichier /opt/ansible/group_vars/all.yml'
echo 'Puis executer la commande suivante :'
echo 'user@pc:~$ (cd /opt/ansible/ && sudo ansible-playbook -i hosts desktop-install.yml)'
echo ''
echo '###################################################################################'

