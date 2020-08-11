#!/bin/bash
######################### SYSTEM UPDATE #########################
sudo apt update
sudo apt upgrade -y

######################### INSTALLS PACKAGES #########################
sudo sh ./package.sh

######################### DRIVE MOUNTING #########################
lsblk
echo "Partition ID (eg sdb1): "
Read DriveID

echo "Mount Folder:"
read MountFolder
mkdir -p /mnt/$MountFolder

sudo echo "/dev/$DriveID    /mnt/$MountFolder   auto    defualts    0   2" >> /etc/fstab
sudo mount -a



######################### CONFIGURES TIMESHIFT #########################
#By Defualt with this edditted config it will save 5 daily backups and one weekly
sudo rm /etc/timeshift/timeshift.json
sudo cp timeshift.conf /etc/timeshift/timeshift.json

######################### CONFIGURE NETWORK SHARES #########################
echo "How Many Shares do you require?"
read ShareNumber
I=1
sudo echo "" >> /etc/samba/smb.conf


while [ $I -le $ShareNumber ]
do
    #Collects required Configuration Information
    echo "Share Name"
    read ShareName
    
    echo "Description"
    read Description

    echo "Path"
    read Path
    sudo mkdir -p $Path

    #Creates Share based on user input
    sudo echo "[$ShareName]" >> /etc/samba/smb.conf
    sudo echo "  #$Description" >> /etc/samba/smb.conf
    sudo echo "  comment = $ShareName" >> /etc/samba/smb.conf
    sudo echo "  path = $Path" >> /etc/samba/smb.conf
    sudo echo "  read only = no" >> /etc/samba/smb.conf
    sudo echo "  browsable = yes" >> /etc/samba/smb.conf
    sudo echo "" >> /etc/samba/smb.conf


    I=$(( $I + 1 ))
done

sudo systemctl restart smbd

######################### Creates SMB Users #########################
echo "SMB Password for Current User"
sudo smbpasswd -a $USER


######################### Syncthing Configuration #########################
#Sets syncthing to run as current user at boot
systemctl enable syncthing@$USER

######################### Append Bashrc #########################
cat bashrc.txt >> ~/.bashrc
