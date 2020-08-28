#!/bin/bash
######################### Collects User Information #########################
echo "How many shares are you adding?"
read ShareNumber

echo "What is the IP of the server?"
read IP

echo "What is the Username?"
read Username

echo "What is the Password?"
read Password



######################### Creates Shares #########################
i=0
while [ $i -le $ShareNumber ]
do
    echo "What is the Share Name?"
    read ShareName

    mkdir -p /media/$USER/$ShareName

    sudo su -c "echo \"//$IP/$ShareName  /media/$USER/$ShareName cifs    username=$Username,password=$Password,noperm    0   0\" >> /etc/fstab"
done

sudo mount -a

