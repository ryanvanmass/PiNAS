#!/bin/bash
######################### SYSTEM UPDATE #########################
sudo apt update
sudo apt upgrade -y

######################### INSTALLS PACKAGES #########################
sudo sh ./package.sh

######################### CONFIGURES TIMESHIFT #########################
#By Defualt with this edditted config it will save 5 daily backups and one weekly
sudo rm /etc/timeshift/timeshift.json
sudo cp timeshift.conf /etc/timeshift/timeshift.json

######################### INITIAL TIMESHIFT BACKUP #########################
sudo timeshift --check

######################### DRIVE MOUNTING #########################
lsblk
echo "Partition ID (eg sdb1): "
read DriveID

echo "Mount Folder:"
read MountFolder
sudo mkdir -p /mnt/$MountFolder

sudo su -c "echo \"/dev/$DriveID    /mnt/$MountFolder   auto    defualts    0   2\" >> /etc/fstab"
sudo mount -a

######################### CONFIGURE NETWORK SHARES #########################
echo "How Many Shares do you require?"
read ShareNumber
I=1
sudo su -c "echo \"\" >> /etc/samba/smb.conf"


while [ $I -le $ShareNumber ]
do
    #Collects required Configuration Information
    echo "Share Name"
    read ShareName
    
    echo "Description"
    read Description

    echo "Path"
    read Path
    sudo mkdir -p /mnt/$MountFolder/$Path

    #Creates Share based on user input
    sudo su -c "echo \"[$ShareName]\" >> /etc/samba/smb.conf"
    sudo su -c "echo \"  #$Description\" >> /etc/samba/smb.conf"
    sudo su -c "echo \"  comment = $ShareName\" >> /etc/samba/smb.conf"
    sudo su -c "echo \"  path = /mnt/$MountFolder/$Path\" >> /etc/samba/smb.conf"
    sudo su -c "echo \"  read only = no\" >> /etc/samba/smb.conf"
    sudo su -c "echo \"  browsable = yes\" >> /etc/samba/smb.conf"
    sudo su -c "echo \"\" >> /etc/samba/smb.conf"


    I=$(( $I + 1 ))
done

sudo systemctl restart smbd

######################### Creates SMB Users #########################
echo "SMB Password for Current User"
sudo smbpasswd -a $USER

######################### Append Bashrc #########################
cat bashrc.txt >> ~/.bashrc
