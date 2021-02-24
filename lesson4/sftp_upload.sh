#!/bin/bash

set -e
LOG_F="./log_upload_sftp_lesson4.log"
exec &> >(tee "${LOG_F}")

sftp -P 22 testuser@207.244.229.74  <<EOF

mkdir upload_sftp_lesson4

put -r /home/ser/softserve_crash-course/sftp_upload upload_sftp_lesson4
#_______________________________________
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ls -al upload_sftp_lesson4

exit
EOF
