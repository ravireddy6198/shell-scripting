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
    if [ $? -ne 0 ]
    then 
        echo " Mysql installation failure"
        exit 1
    else
        echo " Mysql installation success"
    fi
else
    echo " Mysql installation completed already"
fi




######################################

# USERID=$(id -u)

# if [ $USERID -ne 0 ]
# then
#     echo "ERROR:: You must have sudo access to execute this script"
#     exit 1 #other than 0
# fi

# dnf list installed mysql

# if [ $? -ne 0 ]
# then # not installed
#     dnf install mysql -y
#     if [ $? -ne 0 ]
#     then
#         echo "Installing MySQL ... FAILURE"
#         exit 1
#     else
#         echo "Installing MySQL ... SUCCESS"
#     fi
# else
#     echo "MySQL is already ... INSTALLED"
# fi



dnf list installed git

if [ $? -ne 0 ]
then    
    dnf install git -y
    if [ $? -ne 0 ]
    then    
        echo " Git install failure"
    else
        echo " Git install success"
    fi
else
    echo " Git install already"
fi