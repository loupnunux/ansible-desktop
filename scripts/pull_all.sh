#!/bin/bash

cd /opt/ansible
git pull
ansible-galaxy install -f -r requirements.yml

