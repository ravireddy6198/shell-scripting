#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript-logs"
LOG_FILE="$( echo $0 | cut -d "." -f1)"
TIMESTAMP="$(date +%Y-%m-%d-%H:%M:%S)"
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-----$TIMESTAMP.log"


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failue $N"
        exit 1
    else    
        echo -e "$2 is $G success  $N"
    fi

}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 #other than 0
fi

for package in $@
do
    dnf list installed $package &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
        dnf install $package -y &>>$LOG_FILE_NAME
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y ... INSTALLED $N"
    fi
done


# if [ $USERID -ne 0 ]
# then    
#     echo " ERROR:: You must have sudo access to execute this script"
#     exit 1
# fi

# # Loops execution starts

# for package in $@
# do
#     dnf list installed $package &>>$LOG_FILE_NAME
#     if [ $? -ne 0 ]
#     then
#         dnf install $package -y &>>$LOG_FILE_NAME
#         VALIDATE $? "installing $package"
#     else
#         echo -e " Mysql Installed $Y already $N"
#     fi
# done

###############
#     Git Pending
################

