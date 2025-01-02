#!/bin/bash

USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is failue"
        exit 1
    else    
        echo "$2 is success"
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
    echo " Mysql Installed already"
fi