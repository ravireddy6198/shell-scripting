#!/bin/bash


NUM=$1

if [ $NUM -gt 100]
then
    echo " the given $NUM is greater than 100"
else
    echo " the given $NUM is less than 100"
fi