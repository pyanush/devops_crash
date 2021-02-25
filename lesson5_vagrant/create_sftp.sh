#!/bin/bash

#settup logging

set 
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")

#adding user with passwordless access to sudo 
getent passwd $1 &> /dev/null
exist_user="$?"
if [ "$exist_user" != "0" ]
  then
    sudo adduser $1
    echo "test" | sudo passwd $1 --stdin
    sudo usermod -aG wheel $1
    echo "$1 ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
  else
    echo "user $1 already exist"
fi

#updating system and installing vsftpd server

if ! rpm -q --quiet vsftpd ; then
  sudo yum update -y
  sudo yum install vsftpd -y

  #configuring vstpd service

  sudo systemctl start vsftpd
  sudo systemctl enable vsftpd

  #Disable firewalld service
  sudo systemctl stop firewalld
fi

#Backup default config
if [ ! -f /etc/vsftpd/vsftpd.conf.default ] ; then
  sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

  change_config () { 
  grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i "s/^$1.*/$1=$2/" /etc/vsftpd/vsftpd.conf || echo "$1=$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
  }
  #Configuring vsftpd server
  change_config anonymous_enable NO
  change_config local_enable YES
  change_config write_enable YES
  change_config chroot_local_user YES
  change_config allow_writeable_chroot YES
  change_config userlist_enable YES
  change_config userlist_file /etc/vsftpd/user_list
  change_config userlist_deny NO
  change_config chroot_list_enable YES
  change_config chroot_list_file /etc/vsftpd/chroot_list
  change_config pasv_enable YES
  change_config pasv_max_port 10001
  change_config pasv_min_port 10000
  else
  echo "vsftpd.conf already configured"
fi
  #Configuring sftp user
  echo $1 | sudo tee –a /etc/vsftpd/user_list
  echo $1 | sudo tee –a /etc/vsftpd/chroot_list
  #Restarting vsftpd service
  sudo systemctl restart vsftpd
 

