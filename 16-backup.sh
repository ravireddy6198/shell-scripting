#!/bin/bash


USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2

DAYS=${3:-14}

LOGS_FOLDER="/var/log/expense-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME
USAGE(){
    echo -e "$R USAGE:: $N $0 <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]
then
    echo -e "$SOURCE_DIR does not exist"
fi

FILES=$(find /home/ec2-user/app-logs -name "*.log" -mtime +$DAYS)



if [ -n "$FILES" ]  # not empty  ( if there are file to zip)
then
    echo "files to delete: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find /home/ec2-user/app-logs -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
         echo -e "Successfully created zip file for files older than $DAYS"
        while read -r filepath # here filepath is the variable name, you can give any name
        do
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleted file: $filepath"
        done <<< $ZIP_FILE
    else
        echo -e "$R Error:: $N Failed to create ZIP file "
        exit 1
    fi
else
    echo "  files not foung older than $DAYS"
fi