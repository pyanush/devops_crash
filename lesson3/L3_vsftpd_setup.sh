#!/bin/bash

# 1. Setup logging
set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

# 2. Adding user with passwordless access to sudo
sudo adduser $1
sudo passwd $2
sudo usermod -aG wheel $1
echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo
EDITOR='tee -a' visudo

# 3. Updating system and installing vsftpd server
sudo yum update -y
sudo yum install vsftpd -y

# 4. Configuring vsftpd service
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

# 5. Disable firewalld service
sudo sysemctl stop firewalld

# 6. Backup default config
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default

# 7. Function for changing config
change_config () {
 grep -q "^$1" /etc/vsftpd/vsftpd.conf && sudo sed -i
"s/^$1.*/$1=$2/" /etc/vsftpd/vsftpd.conf || echo "$1=$2" |
sudo tee -a /etc/vsftpd/vsftpd.conf
}

# 8. Configuring vsftpd server
change_config anonymous_enable NO
change_config local_enable YES
change_config write_enable YES
change_config chroot_local_user YES
change_config allow_writeable_chroot YES
change_config userlist_enable YES

# 9. Configuring sftp user
echo $1 | sudo tee –a /etc/vsftpd/user_list
echo $1 | sudo tee –a /etc/vsftpd/chroot_list

# 10. Restarting vsftpd service
sudo systemctl restart vsftpd