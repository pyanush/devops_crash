#!/bin/bash
# set -e
# LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
# exec &> >(tee "${LOG_F}")
# echo "Logging setup to ${LOG_F}"
python ssh.py
#sshpass -p '*,<R#!$(2udw{Zgz' sftp testuser@207.244.229.74:/opt/testuser/logfile.log 

# systemctl start firewalld
# systemctl enable firewalld
# #firewall-cmd --state

# systemctl start vsftpd
# systemctl enable vsftpd

# #systemctl stop firewalld
# #firewall

# firewall-cmd --zone=public --permanent --add-port=21/tcp
# firewall-cmd --zone=public --permanent --add-service=ftp
# firewall-cmd --zone=public --permanent --add-port=10000-10001/tcp
#firewall-cmd --reload

#firewall-cmd --state

#systemctl restart vsftpd
#systemctl start firewalld
#systemctl enable firewalld

#echo $1 | tee -a /etc/vsftpd/user_list
#echo $1 | tee -a /etc/vsftpd/chroot_list

echo "=============ftp==============="
