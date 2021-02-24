#!/bin/bash
set -e
# Setup logging
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

# Function for changing ftp config
change_config () {
	grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i "s/^$1.*/$1=$2/" /etc/vsftpd/vsftpd.conf || echo "$1=$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
}

echo "Adding user with passwordless access to sudo"
sudo adduser $1
echo $2 | sudo passwd $1 --stdin
sudo usermod -aG wheel $1
echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
# echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

echo "Installing ftp"
sudo yum update -y
sudo yum install ftp -y
sudo yum install vsftpd -y
#sudo yum install python3 -y
#sudo yum install wget -y
#sudo yum install unzip -y

echo "Configuring vsftpd service"
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

# echo "Disabling firewall"
# sudo systemctl stop firewalld

#echo "Adding firewall rules"
#sudo systemctl start firewalld
#sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
#sudo firewall-cmd --zone=public --permanent --add-service=ftp
#sudo firewall-cmd --reload

echo "Backup deafault vsftpd config"
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

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

# Configuring sftp user
echo $1 | sudo tee –a /etc/vsftpd/user_list
echo $1 | sudo tee –a /etc/vsftpd/chroot_list

echo "Restarting vsftpd service"
sudo systemctl restart vsftpd