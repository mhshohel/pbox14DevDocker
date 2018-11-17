#!/usr/bin/env bash

sudo yum update -y

sudo yum install git -y

sudo yum install jq -y


if [ ! -d "/efs" ]; then
     mkdir /efs
fi

sudo  yum install -y nfs-utils

if [ ! -d "/efs/mounted" ]; then
    sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-6d2b6627.efs.us-east-1.amazonaws.com:/ /efs

	sudo mount | grep efs

	sudo cp /etc/fstab /etc/fstab.bak

	sudo echo 'fs-6d2b6627.efs.us-east-1.amazonaws.com:/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0' | sudo tee -a /etc/fstab

	sudo mount -a

fi


sudo yum install docker -y

sudo usermod -a -G docker ec2-user

sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


sudo chmod +x /usr/local/bin/docker-compose

sudo service docker start
sudo chkconfig docker on