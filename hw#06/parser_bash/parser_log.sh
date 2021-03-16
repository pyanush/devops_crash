#!/usr/bin/env bash


FILE=./ip.log
MONTHS=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

exec 9<$FILE
while read line <&9; do
    echo "$line"  # Вывод строки из файла
    MONTH=`echo "$line" | egrep -o '^\w{3}'`
    DATE=`echo "$line" | egrep -o '\s[0-9]{2}\s'`
    TIME=`echo "$line" | egrep -o '[0-9]{2}\:[0-9]{2}\:[0-9]{2}'`
    HOST=`echo "$line" | egrep -o '(?<=\d{2}\:\d{2}\:\d{2}\s)\w+\s'`
    SERVICE=`echo "$line" | egrep -o '\S+\[[0-9]+\]'`
    MESSAGE=`echo "$line" | egrep -o '(?<=\]\:\s).+$'`
    IP=`echo "$line" | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`

    echo "MONTH=$MONTH"
    echo "DATE=$DATE"
    echo "TIME=$TIME"
    echo "HOSTNAME=$HOST"
    echo "SERVICE=$SERVICE"
    echo "MESSAGE=$MESSAGE"
    echo "IP=$IP"

    # read  # Чтение ввода пользователя
done
exec 9<&-

# for (( i = 0; i < 11; i++ )); do
#   if [[ ${MONTH[$i]} ]]==Jan; then
#     echo $MONTH | sed -e "s/$MONTH/$i"
#   fi
# done
