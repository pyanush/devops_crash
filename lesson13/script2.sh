#!/bin/bash
FILE=/home/testuser/MyProject/lesson/result/access_logs.db
if [ -f $FILE ]; then
   echo "Файл '$FILE' существует."
else
   echo "Файл '$FILE' не найден."
fi
