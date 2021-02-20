#!/bin/bash

#login sftp to cent_os
sftp dseme@192.168.88.2 <<EOF

mkdir FTP_ch3

put -r FTP_ch3

exit
EOF
