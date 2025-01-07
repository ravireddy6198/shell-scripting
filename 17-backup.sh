#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5
MSG=""

while read -r line
do

    #echo $line
    USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F " " '{print $NF}')
    #echo "$PARTITION   : $USAGE"
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then  
        MSG+="$PARTITION exceeds :$USAGE \n "
    fi
done <<< $DISK_USAGE

echo -e "$MSG" |mutt -s "Hight DISK USAGE" ravireddy6198@gmail.com

