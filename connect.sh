#!/bin/bash

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"
greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }

#CHANGE ME
#Path to your private key
path_to_private_key=path_to_your_private_key

#DO NOT CHANGE
container_name=starknet
image_name=eqlabs/pathfinder:latest
path_to_cron_remote=/home/cron.sh

#CHANGE ME
#Ip addresses your servers
servers=(
	bla bla bla
)

#CHANGE ME
#keys from alchemy your apps
keys=(
	bla bla bla
)

main() {
echo ""
echo  "CHOOSE ACTION =>"
echo  ""
echo -ne "
1) CONNECT TO SERVER
2) SETUP SERVER
3) START CONTAINER
4) CREATE CRON JOB
5) CHECK STATUS DOCKER CONTAINER
0) EXIT
Choose an option:"
read -r ans
    case $ans in
	    1) connect ;;
	    2) install_docker ;;
	    3) start_container ;;
	    4) cron ;;
	    5) check_status ;;
	    0) exit 0 ;; 
	    *) exit 1 ;;
	    esac    

}


check_status(){

for index in "${!servers[@]}"
do
		status_container=$(ssh -i $path_to_private_key root@${servers[$index]} "docker ps --filter='name=$container_name' --format '{{.State}}'")
		#echo $($(blueprint ${servers[$index]}) '->')
		if [ -z "$status_container" ]; then echo $(blueprint ${servers[$index]}) '->'  $(redprint 'container not started');
		else if [ "$status_container" = "running" ]; then echo $(blueprint ${servers[$index]}) '->'  $(greenprint $status_container);else echo $(blueprint ${servers[$index]}) '->' $(redprint $status_container);fi;  
		fi
done
}

cron(){

list_servers
    read -r ans
    case $ans in	    
    [1-5]) scp -i $path_to_private_key cron.sh root@${servers[$(expr $ans - 1)]}:/home/
	    ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "sed -i '2i key=${keys[$(expr $ans - 1)]}' $path_to_cron_remote"	
	    ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "echo  '0 * * * * root  sh $path_to_cron_remote' >> /etc/crontab"	
    cron
    ;;    
    0)
        main
        ;;
    *)
        install_docker
        ;;

esac

}

start_container(){
list_servers
read -r ans
    case $ans in
	        [1-5]) is_exist=$(ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} 'docker --version')
	if [ -z "$is_exist" ]; then
	echo "Docker not installed. Please install docker. Point 2 in start menu";       
	else 
		count_containers=$(ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "docker ps --format '{{.Names}}' | grep $container_name | wc -l")
		ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "docker pull $image_name >> /dev/null"
		if (($count_containers == 0)); then
		   echo "test"
		else
			image_id=$(ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "docker inspect --format='{{.Id}}' $image_name")
			current_image_id=$(ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "docker inspect --format='{{.Image}}' $container_name")
			if [ "$image_id" == "$current_image_id" ]; then

				echo "Container actual, restart not needs"
			else

				ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} "bash -s $container_name ${keys[$(expr $ans - 1)]} $image_name" < ./docker_container.sh
			fi
	     	fi	     
	fi
	install_docker
	;;
0)
main
;;
*)
start_container
;;
esac
}


install_docker(){
list_servers
    read -r ans
    case $ans in	    
    [1-5]) ssh -i $path_to_private_key root@${servers[$(expr $ans - 1)]} 'bash -s' < ./installDocker.sh
    install_docker
    ;;    
    0)
        main
        ;;
    *)
        install_docker
        ;;
    esac
}


list_servers(){
echo ""
echo  "CHOOSE SERVER =>"
echo  ""
for index in "${!servers[@]}"
do
	        echo $(greenprint $(expr $index + 1))')' $(blueprint ${servers[$index]})
done
echo "0) Exit"
echo "Choose an option:"
}

connect() {
list_servers	
echo -ne "
Choose an option:  "
    read -r ans
    case $ans in
	    
	    [1-5]) ssh -i $path_to_private_key  root@${servers[$(expr $ans - 1)]};;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Wrong option."
        exit 1
        ;;
    esac
}

main
