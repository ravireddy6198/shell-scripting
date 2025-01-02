#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R failue"
        exit 1
    else    
        echo -e "$2 is $G success"
    fi

}


if [ $USERID -ne 0 ]
then    
    echo " ERROR:: You must have sudo access to execute this script"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Mysql Installation"

else
    echo -e " Mysql Installed $Yalready"
fi

###############
#     Git Pending
################