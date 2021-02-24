#!/bin/bash
set -e
LOG_F="/tmp/sftp_"`date "+%F-%T"`".log"
exec &> >(tee "$LOG_F")
sudo chmod a+x get.sh
#tar cvf log.tar /tmp/
#pwd
#ls -l
HOST="192.168.0.103"
USER="user"
PWD="1"
sftp $USER@$HOST <<EOF
ls -l
lcd /home/user/
get $LOG_F logs.txt
EOF

HOST="192.168.0.103"
USER="user"
PWD=1
ftp -inv $HOST <<EOF
user $USER $PWD
cd /tmp
put $LOG_F
bye
EOF

git config --global user.name polyakpavlo
git config --global user.email poliyakpavlo@gmail.com
sudo git clone https://github.com/pyanush/devops_crash.git
sudo cd ./devops_crash
git branch
git checkout pavlo_polyak_25021982
git branch --set-upstream-to=origin pavlo_polyak_25021982
git pull
sudo mkdir lesson4
sudo cp /home/user/*.log lesson4
git add .
git status
git commit -m "logs add in lesson3"
git push -u origin pavlo_polyak_25021982
git status
