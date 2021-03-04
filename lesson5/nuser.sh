#!/bin/bash
#script that add new user in system and configurate FTP service for him(including SSH/SFTP)
#Configuring logging
	set -e
	LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
	exec &> >(tee "${LOG_F}")
	echo "Logging setup to ${LOG_F}"
#Promt user name
#	read -p "Enter username: " name	
name=$1
pass=$2
#if user exist
if grep -w $name /etc/passwd
then
#Post message about it and skip adding new user
	echo -e "User\033[33m $name\033[0m already exist"
else
#otherwise create NEW user without password request at sudo command
	sudo adduser $name
	echo $pass | sudo passwd $name --stdin
	sudo usermod -aG wheel $name
	sudo echo "$name ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$name
	sudo chmod 0440 /etc/sudoers.d/$name
fi
#Updating system and installing vsftpd server
	sudo yum update -y
	sudo yum install vsftpd -y
#Running vsftpd service
	sudo systemctl start vsftpd
	sudo systemctl enable vsftpd
#Congiguring firewall to allow FTP traffic on Port 21
	sudo systemctl start firewalld
	sudo systemctl enable firewalld
	sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
	sudo firewall-cmd --zone=public --permanent --add-service=ftp
	sudo firewall-cmd --reload
	sudo systemctl restart firewalld
#
#Backup default config of vsfpd service
	ls /etc/vsftpd/ | grep 'vsftpd.conf.default$' || sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default && sudo cp /etc/vsftpd/vsftpd.conf "/etc/vsftpd/vsftpd.conf.default."`date "+%F-%T"`
#
#Function for changing config inside "vsftpd.conf" file
change_config () {
	grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i 's/^$1.*/$1=$2/' /etc/vsftpd/vsftpd.conf || echo "$1=$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
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
#change_config pasv_max_port 10001
#change_config pasv_min_port 10000
#
#Configuring sftp user
	cat /etc/vsftpd/user_list | grep $name && echo $name | tee -a /etc/vsftpd/user_list
	cat /etc/vsftpd/chroot_list | grep $name && echo $name | tee -a /etc/vsftpd/chroot_list
#Creating upload directory and changing permissions
    sudo mkdir -p /home/$name/ftp/upload
    sudo chmod 0550 /home/$name/ftp
    sudo chmod 0750 /home/$name/ftp/upload
    sudo chown -R $name: /home/$name/ftp
#Restarting vsftpd service
	sudo systemctl restart vsftpd
#Restarting sft service
	#sudo systemctl restart sshd
	echo -e "Configuring user\033[33m $name\033[0m permissions for SFTP server was \033[32mDone !\033[0m"