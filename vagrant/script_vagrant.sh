#!/bin/bash

change_config () {
grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i "s/^$1.*/$1-$2/" /etc/vsftpd/vsftpd.conf || echo "$1-$2" | sudo tee -a /etc/vsftpd/vsftpd.conf
}


sudo adduser $1
echo $2 | sudo passwd $1 --stdin
sudo usermod -aG wheel $1
echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

sudo yum update -y
sudo yum install ftp vsftpd python3 wget unzip -y

sudo systemctl start vsftpd
sudo systemctl enable vsftpd

sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

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

echo $1 | sudo tee -a /etc/vsftpd/user_list
echo $1 | sudo tee -a /etc/vsftpd/chroot_list

sudo systemctl restart vsftpd

grep -q "^PasswordAuthentication" /etc/ssh/sshd_config && sudo sed -i "s/^PaswordAuthentication.*/PasswordAuthentication yes/" || echo "PasswordAuthentication yes"
grep -q "^LogLevel" /etc/ssh/sshd_config && sudo sed -i "s/^LogLevel.*/LogLevel DEBUG3/" /etc/ssh/sshd_config || echo "LogLevel DEBUG3"
sudo systemctl restart sshd

wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
