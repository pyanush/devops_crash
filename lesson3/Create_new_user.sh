#!/bin/bash


set -e
LOG_F="Create_user_$1_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "=====Logging setup to ${LOG_F}====="


echo ==========adding user==========
adduser $1
passwd $1
sudo usermod -aG wheel $1
echo '$1 ALL=(ALL) NOPASSWD:ALL'>/etc/sudoers.d/$1
sudo chmod 0440 /etc/sudoers.d/$1

sudo mkdir /home/$1/.ssh
sudo chown -R $1:$1 /home/$1/.ssh/
echo ================================