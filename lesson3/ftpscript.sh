#!/bin/bash

#Setup tme-zone
sudo timedatectl set-timezone Europe/Kiev

#Setup logging
set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

#Adding user with passwordless access to sudo
sudo adduser $1
sudo passwd $1
sudo usermod -aG wheel $1
echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

#Updating system and installing vsftpd server
sudo yum update -y
sudo yum install vsftpd -y

#Installing EPEL Repo
sudo yum install epel-release -y

#Installing additional packages
sudo yum install mc -y
sudo yum install htop -y
sudo yum install nmap -y

#Configuring vsftpd service
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

#Backup default config
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

#Firewall rule to allow port 21
sudo systemctl start firewalld
sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --reload

#Open ports 10000-10001 for passv
sudo firewall-cmd --zone=public --permanent --add-port=10000-10001/tcp
sudo firewall-cmd --reload

#Function for changing config
change_config () {
sudo grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i 's/^$1.*/$1=$2/' /etc/vsftpd/vsftpd.conf || echo "$1=$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
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

#Configuring sftp user
echo $1 | sudo tee –a /etc/vsftpd/user_list
echo $1 | sudo tee –a /etc/vsftpd/chroot_list

#Restarting vsftpd service
sudo systemctl restart vsftpd

#Function for boxed message
function box_out()
{
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 3
  echo " -${b//?/-}-
| ${b//?/ } |"
  for l in "${s[@]}"; do
    printf '| %s%*s%s |\n' "$(tput setaf 4)" "-$w" "$l" "$(tput setaf 3)"
  done
  echo "| ${b//?/ } |
 -${b//?/-}-"
  tput sgr 0
}

#Done message
box_out "Created user $1 with passwordless access to sudo" "Installed & configured vsftpd" "Setted up firewall rules" "Installed: mc, htop, nmap"