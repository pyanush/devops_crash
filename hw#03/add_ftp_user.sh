#!/usr/bin/env bash

NAME=$1
PWD=$2

echo "USAGE: add_ftp_user.sh [username] [password]"

# проверка входных агрументов
if [ -n "$NAME" ]
then
    echo "USERNAME: $NAME"
else
    echo "ERROR: username isn't set"
    exit
fi

if [ -n "$PWD" ]
then
    echo "PASSOWRD: $PWD"
else
    echo "ERROR: password isn't set"
    exit
fi

# !!! проверка на наличие пользователя в системе

# создаю пользователя и его папку для FTP файлов
sudo useradd -c "FTP user" -m -d /home/$NAME -s /bin/bash $NAME

sudo echo $PWD | passwd $NAME --stdin

# создаю папку под ftp файлы
sudo mkdir /home/$NAME/ftp

# назначаю владельца ftp папки
sudo chown $NAME:$NAME /home/$NAME/ftp

# создаю пустой конфигурационный файл для пользователя
sudo touch /etc/vsftpd/users/$NAME

# прописываю домашний каталог ftp пользователя
sudo echo "local_root=/home/$NAME/ftp" >> /etc/vsftd/users/$NAME

# добавляю пользователя в список разрешенных к подключению
sudo echo "$NAME" >> /etc/vsftd/user_list

# задаю права каталога пользователя
sudo chmod 0777 /home/$NAME/ftp

# перезапускаю службу vsftpd
sudo systemctl restart vsftpd
