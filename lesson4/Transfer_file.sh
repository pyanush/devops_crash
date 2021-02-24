#!/bin/bash

set -e
LOG_F="transfer_file_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "=====Logging setup to ${LOG_F}====="


#login sftp to cent_os
sftp -P 22 $1@$2
echo ======== Start SFTP =========

mkdir taras_folder
put -r taras_folder
put -r ./file_for_tranfer.txt ./taras_folder/


echo ==================
echo | Uploaded files |
echo ==================
ls -al taras_folder
exit
