#!/bin/sh
#chmod a+x sftp.sh

#add user
sudo adduser $1
sudo passwd $1
sudo usermod -aG wheel $1
sudo echo "$1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$1
#sudo echo "$1 ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR= "tee -a" visudo

# user sudo
#sudo chmod 0440 /etc/sudoers.d/$1
#sudo chown -R $1:$1 /home/$1/.ssh/

sudo yum update -y
sudo yum install epel-release -y
sudo yum install vsftpd -y
sudo yum install ftp -y
#sudo yum install bind-utils -y
#sudo yum install net-tools -y
#sudo yum install network-scripts -y

sudo systemctl start firewalld
sudo systemctl enable firewalld
#sudo firewall-cmd --state

sudo systemctl start vsftpd
sudo systemctl enable vsftpd

#sudo systemctl stop firewalld
#firewall

sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --zone=public --permanent --add-port=10000-10001/tcp
sudo firewall-cmd --reload

#sudo firewall-cmd --state

#config

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
sudo echo "pasv_min_port=10000" >> /etc/vsftpd/vsftpd.conf
sudo echo "pasv_max_port=10001" >> /etc/vsftpd/vsftpd.conf
#sudo vi /etc/vsftpd/vsftpd.conf

sudo systemctl restart vsftpd

sudo systemctl start firewalld
sudo systemctl enable firewalld

echo $1 | sudo tee -a /etc/vsftpd/user_list
echo $1 | sudo tee -a /etc/vsftpd/chroot_list

# add new ftp test 

#sudo adduser $2
#sudo passwd $2
#sudo echo $2 | sudo tee -a /etc/vsftpd/user_list
#sudo mkdir -p /home/$2/ftp/upload
#sudo chmod 550 /home/$2/ftp
#sudo chmod 750 /home/$2/ftp/upload
#sudo chown -R $2: /home/$2/ftp

echo "=============ftp==============="


#HOST="207.244.229.74"
#USER=$1
#PWD=$2
#PORT ="22"
#sftp -P $PORT $USER@$HOST <<EOF
#ls -l
#lcd /$2
#put $LOG_F logs.txt
#EOF


#sudo git config --global user.name polyakpavlo
#sudo git config --global user.email poliyakpavlo@gmail.com
#sudo git clone https://github.com/pyanush/devops_crash.git
#sudo cd ./devops_crash

#sudo git config --global user.name polyakpavlo
#sudo git config --global user.mail poliyakpavlo@gmail.com
#sudo git clone https://github.com/PolyakPavlo/DevOps.git
#cd DevOps/
#git branch polyakpavlo_25021982
#git branch
#git checkout polyakpavlo_25021982
#git branch --set-upstream-to=origin polyakpavlo_25021982
#git pull
#sudo mkdir lesson3
#sudo cd lesson3
#sudo cp /tmp/*.log lesson3
#git add .
#git status
#git commit -m "logs add in lesson3"
#git push -u origin polyakpavlo_25021982
#git status
