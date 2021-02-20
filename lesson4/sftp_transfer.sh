#!/bin/bash

#Transfer directory ~/sftp_transfer to 192.168.56.102 ftpuser home directory

#logging
set -e
LOG_F="/tmp/sftp-transfer_"`date "+%F-%T"`".log"

echo "Logging to ${LOG_F}"

#Transferring files 

scp -v -r ~/sftp_transfer ftpuser@192.168.56.102:~/ 2> ${LOG_F} 

