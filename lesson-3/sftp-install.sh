#!/bin/bash

#Setup logging
set -e
LOG_F="/tmp/sftp-server-setup"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")

#Update system
sudo yum -y update
[ $? -eq 0 ] && echo -e "\033[32mSystem update successfully\033[0m" || echo -e "\033[31mFailed to update system\033[0m"

#Installing additional packages
sudo yum -y install perl net-tools nano 

#User creation
echo "---------------------------------------------------------------------"
echo "                        Create new FTP user                          "
echo "---------------------------------------------------------------------"
read -p "*   Enter username: " username
read -s -p "*   Enter password: " password
group=wheel

     #Creating a new user and set password for him
     crypt_passwd=$(perl -e 'print crypt($ARGV[0], "password")' $password)  
     useradd -m -p $crypt_passwd $username

     #Adding user to sudo group
     sudo usermod -a -G $group $username

     #Creating upload directory
     sudo mkdir -p /home/$username/ftp/upload

     #Changing permissions
     sudo chmod 550 /home/$username/ftp
     sudo chmod 750 /home/$username/ftp/upload
     sudo chown -R $username: /home/$username/ftp

     #Access to SUDO commands without a password
     echo "$username ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo   

#Install and start FTP service
sudo yum install vsftpd -y  
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

#Configure rule for firewall to allow FTP traffic on Port 21
sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --reload  

#Making backup of vsftpd config file
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default        

#Function for changing config file
change_config () { 
grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i "s/^$1.*/$1=$2/" /etc/vsftpd/vsftpd.conf || echo "$1=$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
}

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

#Add user to FTP userlist and chroot list
echo $username | sudo tee –a /etc/vsftpd/user_list
echo $username | sudo tee –a /etc/vsftpd/chroot_list  

# Restarting FTP service
sudo systemctl restart vsftpd
