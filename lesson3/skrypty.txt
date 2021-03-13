
usermod -aG wheel mykola
lid -g wheel
chmod 0440 /etc/sudoers.d/mykola
chown -R mykola:mykola /home/mykola/.ssh
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g'\ /etc/ssh/sshd_config
sudo yum update -y
sudo yum install vsftpd -y
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl stop firevalld
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
*,<R#!$(2udw{Zgz