#!/bin/bash

ssh_ip='REMOTE_IP'
ssh_user='SSH_USER'
ssh_pass='SSH_PASS'
commands_file=$(dirname "$0")'/GitSwitcher.sh'

command -v sshpass >/dev/null 2>&1 || { sudo apt-get install sshpass; }

sshpass -p ${ssh_pass} ssh ${ssh_user}@${ssh_ip} 'bash -s' < ${commands_file}

read;
