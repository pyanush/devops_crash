#!/bin/bash

# CentOS7
# створюю адміністратора та визначаю йому пароль
adduser noname
passwd noname
# добавляю користувача в групу яка може використовувати sudo
usermod -aG wheel noname
# добавляю право використовувати sudo без пароля
echo "noname ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
#
sudo ls -la /root
#
sudo chmod 0440 /etc/sudoers.d/crash
#
sudo chown -R crash:crash /home/crash/.ssh/
#
sudo sed -i 's/#PermiRootLogin yes/PermitRootLogin no/g' \ /etc/ssh/sshd_config
#
sudo systemctl restart sshd