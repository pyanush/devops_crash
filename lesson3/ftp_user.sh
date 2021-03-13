#!/bin/bash
set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".Log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"
echo uname -a
echo ip address
echo ip route
echo
echo

#Function for changing config
change_config () {
    grep -G "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i 's/^$1.*/$1=$2/' /etc/vsftpd/vsftpd.conf || echo "$1=$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
}

echo "Adding user with passwordless access to sudo"
sudo adduser $1
sudo passwd $1
sudo usermod -aG wheel $1
echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

echo "Updating system and installing vsftpd server"
sudo yum update -y
sudo yum install vsftpd -y

echo "Configuring vsftpd service"
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

echo "Disable firevalld service"
sudo systemctl stop firevalld

echo "Backup default config"
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

echo "Configuring vsftpd server"
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
echo "Configuring sftp user"
echo $1 | sudo tee a /etc/vsftpd/user_list
echo $1 | sudo tee a /etc/vsftpd/chroot_list

echo "Restarting vsftpd service"
sudo systemctl restart vsftpd


