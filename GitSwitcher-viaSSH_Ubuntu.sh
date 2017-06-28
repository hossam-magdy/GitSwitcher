#!/bin/bash

#sudo apt-get install sshpass;
commands_file=$(dirname "$0")'/GitSwitcher.sh'
ssh_ip='REMOTE_IP'
ssh_user='SSH_USER'
ssh_pass='SSH_PASS'

sshpass -p ${ssh_pass} ssh ${ssh_user}@${ssh_ip} 'bash -s' < ${commands_file}
read;