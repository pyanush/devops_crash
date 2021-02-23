#!/bin/bash

# 1. Enable logging for file uploading to FTP server
set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")

# 2. 
echo Please, enter the filename, you want to upload (make sure to specify its full path, including directory)
read file_name
echo So, your file is $file_name

# 3. Actual file uploading process
echo Let's upload your file to the server. Please, give "admin" password
read admin_pass
echo Here we go!Your file will be saved at FTP server -> Documents folder
# Sample is: scp "Trafoier_feat_Sophiella__Take_Me_Home.mp3" admin@192.168.43.39:Documents
scp $file_name admin@192.168.43.39:Documents

# 4. TBD - Add-up verification if the file was acutaly successfully uploaded to the destination