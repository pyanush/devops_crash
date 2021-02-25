#!/bin/bash

#Setup logging
set -e
LOG_F="./logging-transferring.log"
exec &> >(tee -a "${LOG_F}")

#Make your choice
echo "==========================================="
echo "             FILE TRANSFERRING             "
echo "==========================================="
echo "*   Enter 'u' to UPLOAD files on server"
echo "*   Enter 'd' to DOWNLOAD files from server"
echo "==========================================="
echo -e "*   Enter your option: " | tr -d '\n';
read option;
echo -e "===========================================\n"
echo " "

#Upload files on FTP server
if [ $option == u ]
then
    
    scp -v -P 2222 ~/Pictures/* ftpuser@127.0.0.1:/home/ftpuser/ftp/upload

#Download files from FTP server
elif [ $option == d ]
then

    scp -v -P 2222 ftpuser@127.0.0.1:/home/ftpuser/ftp/upload/* ~/

fi