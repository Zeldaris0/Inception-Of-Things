#! /bin/bash

if [ -z $1 ]; then
        echo "Please enter the ip addr of the machine that will recieve the files"
        exit 0
fi
rsync -a ./* nhamid@$1:.
