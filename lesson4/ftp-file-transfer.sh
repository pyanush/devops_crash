#!/bin/bash
set -e
# Setup logging
LOG_F="/tmp/ftp-file-transfer_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"

echo "Transfering full dir"
scp -vr ~/ftp/upload bob@192.168.1.137:~/ftp/
#echo "Transfer files"
#scp ~/ftp/upload/* bob@192.168.1.137:~/ftp/upload/

# Some choice if needed
#PS3='Please enter your choice: '
#options=("Remove input files from ~/ftp/upload/*" "Quit")
#select opt in "${options[@]}"
#do
#    case $opt in
#        "Remove input files from ~/ftp/upload/*")
#            rm ~/ftp/upload/*
#            ;;
#        "Quit")
#            break
#            ;;
#        *) echo "invalid option $REPLY";;
#    esac
#done

echo "Transfer finished"

