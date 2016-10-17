#!/bin/bash

HOST_NAME=prophet-01
HOST_IP=172.27.4.15
GATEWAY=172.27.0.1
ISO_PATH=/root/iso
VOLUME_PATH=/home/whwstar/volume/prophet2.0/master
image=centos65:latest

if [ `docker ps -a | grep prophet-01 | wc -l` -eq 0 ];then
    mkdir -p $VOLUME_PATH
    docker run -itd -h $HOST_NAME --name=$HOST_NAME --net=none -v $ISO_PATH:$ISO_PATH -v  $VOLUME_PATH:/bigdata $image /bin/bash
    pipework br0 $HOST_NAME $HOST_IP/20@$GATEWAY
    docker exec -d $HOST_NAME /usr/sbin/sshd -D
elif [ `docker ps -a | grep prophet-01 | wc -l` -eq 1 ];then
    docker start $HOST_NAME
else
    echo "docker start exception"
fi

