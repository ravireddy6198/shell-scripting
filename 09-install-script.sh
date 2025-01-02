#!/bin/bash

USERID=$(id -u)


if [ $USERID -ne 0 ]
then
    echo " ERROR:: You must have sudo access to execute this script"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    if[ $? -ne 0 ]
    then 
        echo " Mysql installation failure"
        exit 1
    else
        echo " Mysql installation success"
    fi
else
    echo " Mysql installation completed already"
fi