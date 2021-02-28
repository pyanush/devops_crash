#!/bin/bash

set -e
LOG_F="install_sftp_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "=====Logging setup to ${LOG_F}====="

sudo yum install epel-release
sudo yum update -y
sudo yum install vsftpd

sudo systemctl start vsftpd
sudo systemctl enable vsftpd

# sudo systemctl stop firewalld

sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --reload

sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

sudo echo "" >> /etc/vsftpd/vsftpd.conf
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

sudo systemctl restart vsftpd

echo ================================