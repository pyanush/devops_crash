#!/bin/bash
#script that download/upload directory to sftp server
#start logining
set -e
	LOG_F="/tmp/sftp_session."`date "+%F-%T"`".log"
	exec &> >(tee "${LOG_F}")
	echo "Logging transfer of files to ${LOG_F}"
#prompting what does user whant to do
	echo 	"Files from/to current directory will be uloaded/downloaded"
	echo -e "Chose what you want to do with files, \n download from FTP 'd' or upload on FTP 'u':"
	read -n 1 -p "d / u :" option
#make option lower case
	declare -l option
	option=$option
if [ $option == u ]
then
#uploading curent directory to ftp using scp command
	echo -e "\nUploading current directory to FTP"
	scp -rv -P 22  ./ testuser@207.244.229.74:~/.
elif [ $option == d ]
then
#downloadinf content from ftp to current directory
	echo -e "\nDownloading files from FTP"
	scp -rv -P 2021  nikolay@192.168.0.208:~/ftp/upload/. ./
else 
	echo -e "Warning, you type wrong options\n use 'd' or 'u' next time!"
fi
