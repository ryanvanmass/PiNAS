# Introduction
PiNAS is a simple and easy way to deploy SMB Shares. With Scripts for both the server configuration as well as the client Configuration it makes deployment of a new SMB server as easy and painless as possible

## Server Dependancies
__Note:__ Will be installed as part of the set up
* Samba
* OpenVPN
* net-tools
* Syncthing
* Timeshift
* iotop
* htop
* iftop

# Installation
## Server
__Note:__ You will need to know the static IP address for the sever to complete setup (run `ip address`)
1. `git clone https://www.github.com/ryanvanmass/pinas`
2. `cd pinas/Server`
3. `sudo sh ./setup.sh`
4. Follow Onscreen Prompts


## Client
__Note:__ You will need to know the static IP address for the sever to complete setup
1. `git clone https://www.github.com/ryanvanmass/pinas`
2. `cd pinas/Client`
3. `sudo sh ./setup.sh`
4. Follow Onscreen Prompts

# How Does it Work?
## Sever
step 1: it will run a system update to ensure that your server is running all the latest packages

step 2: it will run a script that will install all the dependancies

Step 3: It will walk you through mounting the drive that the network shares are going to be stored on

step 4: It will configure timeshift to run daily and weekly backups of the server configuration

Step 5: I will walk you through creating the SMB Shares

Step 6: It will walk you through creating your SMB Credentials

Step 7: it will append some useful alias's to your .bashrc file

## Client
Step 1: It will collect the Server Information and Login Credentials from you

Step 2: I will walk you through creating the file system mounts and mounting the SMB Shares in the file system (through Fstab)

Step 3: It will mount all shares