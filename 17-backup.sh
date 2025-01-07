#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5

while read -r line
do

    echo $line
    USAGE=$(echo $line | awk -F " " '{print $NF}')
    echo $USAGE
done <<< $DISK_USAGE