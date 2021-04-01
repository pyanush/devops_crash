#!/bin/bash
#script that download log file from sftp server
HOST=testuser@207.244.229.74
# i know it`s BAD practice
PASS='*,<R#!$(2udw{Zgz'
# chown /result
sshpass -p $PASS scp -o StrictHostKeyChecking=no  $HOST:/opt/testuser/logfile.log /home/devops/logs/logfile
tail -n 100000 /home/devops/logs/logfile > /home/devops/logs/logfile.log 
touch /home/devops/logs/.logfile.log

# git checkout -- erase my beautiful construction that was waiting result file
sleep 45
echo "Here we go"
rm /home/devops/logs/logfile /home/devops/logs/.logfile.log
if [ -f /home/devops/upload/access_logs.xlsx ]
then 
sshpass -p $PASS scp -o StrictHostKeyChecking=no  /home/devops/upload/access_logs.xlsx $HOST:/home/testuser/mykhailo_kupchanko/
echo -e "File was\033[32m successfuly\033[0m uploaded to DevOps demo server"
else
echo -e "\033[33mWarning!\033[0mFile wasn't upload to target server and exist only while docker-composer is up"
echo "He is still avaliable on containered SFTP server, by -port 223 and devops/pass login and password"
fi 
# while ![ -f /home/devops/upload/logfile.log ]
# sshpass -p $PASS scp -o StrictHostKeyChecking=no  /home/devops/upload/access_log.xls $HOST:/home/testuser/mykhailo_kupchanko/

