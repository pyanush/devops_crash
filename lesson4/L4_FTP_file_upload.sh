#!/bin/bash

# 1. Enable logging for file uploading to FTP server
set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")

# 2. 
echo Please, enter the filename, you want to upload (make sure to specify its full path, including directory)
read file_name
echo So, your file is $file_name

# 3.
echo And now specify source host as well as destination host and its folder
echo source_host
read source_host
#echo source_folder
#read source_folder
echo destination_host
read destination_host
echo destination_folder
read destination_folder

# 4. Actual file uploading process
echo Let\'s upload your file to the server. Please, give "admin" password

# Sample: scp "Trafoier_feat_Sophiella__Take_Me_Home.mp3" admin@192.168.43.39:Documents

scp admin@$source_host/$file_name admin@$destination_host:$destination_folder

# 5.
echo YAHOO! Your file has been saved at FTP server. You may find it at $destination_host:$destination_folder

TBD - Add-up verification if the file was acutaly successfully uploaded to the destination

#   PWD: *,<R#!$(2udw{Zgz