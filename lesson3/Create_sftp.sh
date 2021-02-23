#!/bin/bash

set -e
LOG_F="Install SFTP"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

sudo yum install epel-release
sudo yum update -y
sudo yum install vsftpd

sudo systemctl stop firewalld

sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --reload

sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

sed 's/anonymous_enable=YES anonymous_enable=NO' /etc/vsftpd/vsftpd.conf
sed 's/#write_enable=YES write_enable=YES' /etc/vsftpd/vsftpd.conf
sed 's/#chroot_local_user=YES chroot_local_user=YES' /etc/vsftpd/vsftpd.conf
sed 's/#/(default follows) allow_writeable_chroot=YES' /etc/vsftpd/vsftpd.conf
sed 'i/tcp_wrappers=YES userlist_deny=NO' /etc/vsftpd/vsftpd.conf
sed 'i/userlist_deny=NO userlist_file=/etc/vsftpd/user_list' /etc/vsftpd/vsftpd.conf

sudo systemctl restart vsftpd
