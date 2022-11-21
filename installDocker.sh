#!/bin/bash

apt-get update
apt-get upgrade -y

serviceName=docker

if systemctl --all --type service | grep -q "$serviceName";then
	    echo "$serviceName exists."
    else
       echo "$serviceName does NOT exist. Intalling ..."

	apt-get remove docker docker-engine docker.io
	apt install docker.io -y
	systemctl start docker
	systemctl enable docker
fi
serviceName1="cron"

if systemctl --all --type service | grep -q "$serviceName1";then
    	    echo "$serviceName1 exists."
else
	        echo "$serviceName1 does NOT exist."

		apt install cron -y 
		systemctl start cron
		systemctl enable cron
fi

