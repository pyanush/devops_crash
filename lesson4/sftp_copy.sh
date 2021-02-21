#!/bin/bash

#settup logging
set -e
LOG_F="./loggin_upload_to_sftp.log"
exec &> >(tee "${LOG_F}")

#login sftp to cent_os
sftp dseme@192.168.88.2 <<EOF

mkdir FTP_ch3

put -r FTP_ch3
put -r ./loggin_upload* ./devops_crash/lesson4 
##################
# Uploaded files #
##################
ls -l FTP_ch3
exit
EOF

