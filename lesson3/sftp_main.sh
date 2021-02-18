#!/bin/bash

#add user

nmcli
sudo adduser $1
sudo passwd $1
sudo usermod -aG wheel $1
#sudo echo "$1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$1
sudo echo "$1 ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR= "tee -a" visudo

sudo cat /etc/passwd
sudo ls -ls /root

sudo chmod 0440 /etc/sudoers.d/$1
sudo chown -R $1:$1 /home/$1/.ssh/

#install

sudo yum update -y
sudo yum install vsftpd -y

#sudo yum install nano -y
#sudo yum install ftp -y
#sudo yum install bind-utils -y
#sudo yum install net-tools -y
#sudo yum install networt-scripts -y
#sudo yum install epel-release -y
#sudo yum install java-1.8.0-openjdk.x86_64 -y
#sudo yum install wget -y
#sudo yum install htop -y

sudo systemctl enable vsftpd
sudo systemctl start vsftpd
sudo systemctl stop firewalld

#firewall

sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --reload

#config

sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
sudo echo "anonymous_enable=NO" >> /etc/vsftpd/vsftpd.conf
sudo echo "local_enable=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "write_enable=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "userlist_enable=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "userlist_file=/etc/vsftpd/user_list" >> /etc/vsftpd/vsftpd.conf
sudo echo "userlist_deny=NO" >> /etc/vsftpd/vsftpd.conf
sudo echo "chroot_list_enable=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "chroot_list_file=/etc/vsftpd/chroot_list" >> /etc/vsftpd/vsftpd.conf
sudo echo "pasv_enable=YES" >> /etc/vsftpd/vsftpd.conf
sudo echo "pasv_min_port 10000" >> /etc/vsftpd/vsftpd.conf
sudo echo "pasv_max_port=10001" >> /etc/vsftpd/vsftpd.conf
#sudo vi /etc/vsftpd/vsftpd.conf

sudo systemctl restart vsftpd

echo $1 | sudo tee -a /etc/vsftpd/user_list
echo $1 | sudo tee -p /etc/vsftpd/chroot_list


# add new ftp test 

sudo adduser $2
sudo passwd $2
sudo echo $2 | sudo tee -a /etc/vsftpd/user_list
sudo mkdir -p /home/$2/ftp/upload
sudo chmod 550 /home/$2/ftp
sudo chmod 750 /home/$2/ftp/upload
sudo chown -R $2: /home/$2/ftp
htop

touch /tpm/log/vsftpd.log && chmod 600 /var/log/vsftpd.log
 
netstat -tulnp | grep vsftpd

set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"
