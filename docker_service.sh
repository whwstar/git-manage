#!/bin/bash

green=`tput setaf 2`
red=`tput setaf 1`
reset=`tput sgr0`

C_NAME_A=`docker ps | awk -F ' ' '{print $NF}' |sed '1d'`
C_NAME_D=`docker ps -a | awk -F ' ' '{print $NF}' |sed '1d'`


function stop_docker() {
    for i in $C_NAME_A
    do
        docker stop $i
           if [ $? == 0 ];then
            echo "${green}container $i successful stop"
           else
            echo "${red}container $i stop exception"
           fi
    done
}

function start_docker(){
    for i in $C_NAME_D
    do
        docker start $i
            if [ $? == 0 ]; then
                echo "${green}container $i successful start"
            else
                echo "${red}container $i start expection"
                
            fi
    done
}

if [ $# -eq 1 ]; then
    case $1 in 
        start)
            start_docker
            ;;
        stop)
            stop_docker
            ;;
        restart)
            stop_docker
            start_docker
            ;;
        *)
            echo "Usage $0 start|stop|restart"
    esac
fi
echo "${reset}"
