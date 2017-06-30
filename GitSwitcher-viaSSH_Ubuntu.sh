#!/bin/bash

ssh_ip='REMOTE_IP';
ssh_user='SSH_USER';
ssh_pass='SSH_PASS';
commands_file=$(dirname "$0")'/GitSwitcher.sh';

# https://packages.ubuntu.com/xenial/amd64/sshpass/download
command -v sshpass >/dev/null 2>&1 || { sudo apt-get install sshpass; };
# plink http://manpages.ubuntu.com/manpages/wily/man1/plink.1.html

sshpass -p ${ssh_pass} ssh ${ssh_user}@${ssh_ip} 'bash -s' < ${commands_file};

read -n 1 -s;
