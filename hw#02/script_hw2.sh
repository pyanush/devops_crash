#!/bin/bash

# Install FTP service
sudo yum -y install vsftpd
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
# Configure firewall 
sudo firewall-cmd --zone=public --permanent --add-port=21/tcp
sudo firewall-cmd --zone=public --permanent --add-service=ftp
sudo firewall-cmd --reload
# Configure firewall using iptables
sudo iptables -A INPUT -p tcp --dport 20 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 20 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 21 -m state --state ESTABLISHED -j ACCEPT
# Create FTP-users group
grp=ftpusers
sudo groupadd $grp
# Create a new FTP user

usr=ftp-user
sudo adduser --home-dir /home/ftp/ --create-home --shell /sbin/nologin $usr         # create new user 
echo "ftpuser" | passwd --stdin $usr                                                # create password for user
# Create a new FTP group
sudo groupadd $grp                                  # create new group
sudo usermod -a -G $grp $usr                        # add a user to a group 
sudo chgrp -R $grp /home/ftp/$usr                   # change owner-group folder
sudo chmod -R 740 /home/ftp/$usr                    # 
sudo chown -R $usr: /home/ftp/$usr                  # 
# Create folder for personal FTP settings users
sudo mkdit /etc/vsftpd/users
# Configure vsFTPd
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default         # backup default config VSFTPD
echo "$usr" | sudo tee -a /etc/vsftpd/user_list                         # added username in access list vsftpd
sudo touch /etc/vsftpd/users/$usr                                       # Создаю папку FTP пользователей для настроек персональных параметров
sudo echo "local_root=/home/ftp/$usr/" >> /etc/vsftpd/users/$usr        # Домашний каталог пользователя

# change vsftpd.conf
sudo nano /etc/vsftpd/vsftpd.conf
# запрещаем анонимный вход
"anonymous_enable=NO"
#
"local_enable=YES"
#
"write_enable=YES"
# ограничываем пользователя в своей домашней директории
"chroot_local_user=YES"
# отключаю проверку разрешения на запись
"allow_writeable_chroot=YES"
#
"userlist_enable=YES"
#
"userlist_file=/etc/vsftpd/user_list"
#
"userlist_deny=NO"
#
# комментируем строку в файле /etc/pam.d/vsftp для отключения проверки оболочки
"#auth required pam_shells.so"

# reload vsftpd
sudo systemctl restart vsftpd



