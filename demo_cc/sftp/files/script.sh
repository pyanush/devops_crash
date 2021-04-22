#!/bin/bash
#script that download log file from sftp server
HOST=testuser@207.244.229.74
# i know it`s BAD practice
PASS='*,<R#!$(2udw{Zgz'
sshpass -p $PASS scp -o StrictHostKeyChecking=no  $HOST:/opt/testuser/logfile.log /home/devops/logs/logfile
head -n 100000 /home/devops/logs/logfile > /home/devops/logs/logfile.log 
touch /home/devops/logs/.logfile.log
# waiting for file and dowload it to remove sftp
CNT=20
while [ $CNT -gt 0 ]
do
sleep 5
CNT=$(( $CNT - 1 ))
if [ -f /home/devops/upload/.access_logs.xlsx ]
then
#removing temporary files
rm /home/devops/logs/logfile /home/devops/logs/.logfile.log /home/devops/upload/.access_logs.xlsx
sshpass -p $PASS scp -o StrictHostKeyChecking=no  /home/devops/upload/access_logs.xlsx $HOST:/home/testuser/mykhailo_kupchanko/access_logs_`date +%Y-%m-%d-%H:%M`.xlsx
echo -e "File was\033[32m successfuly\033[0m uploaded to DevOps demo server"
break
elif [ $CNT -eq 0 ]
then
echo -e "\033[33mWarning!\033[0mFile wasn't upload to target server and exist only while docker-compose is up"
echo "He is still avaliable on containered SFTP server, by -port 223 and devops/pass login and password"
break
fi
echo "$(( 20-$CNT )) loop ended. Waiting for result file"
done
