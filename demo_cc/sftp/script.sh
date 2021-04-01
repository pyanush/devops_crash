#!/bin/bash
#script that download log file from sftp server
HOST=testuser@207.244.229.74
# i know it`s BAD practice
PASS='*,<R#!$(2udw{Zgz'
sshpass -p $PASS scp -o StrictHostKeyChecking=no  $HOST:/opt/testuser/logfile.log /home/devops
# shpass -f "passfile" scp -o StrictHostKeyChecking=no  -r testuser@207.244.229.74:/opt/testuser/logfile.log /logs/
