#!/bin/bash


image_name=eqlabs/pathfinder:latest
container_name=startknet

docker_run(){
        docker run --rm \
                -d --name $container_name \
                -p 9545:9545 --user "$(id -u):$(id -g)" \
                -e RUST_LOG=info -e PATHFINDER_ETHEREUM_API_URL="https://eth-goerli.g.alchemy.com/v2/$key" \
                -v $HOME/pathfinder:/usr/share/pathfinder/data \
                $image_name
}

docker pull $image_name >> /dev/null

is_null_container=$(docker ps -q --filter "name=$container_name")
if [ -z "$is_null_container" ]
then
        docker_run
else
        image_id=$(docker inspect --format='{{.Id}}' $image_name)
        current_image_id=$(docker inspect --format='{{.Image}}' $container_name)
        if [ "$image_id" = "$current_image_id" ]; then
                echo "Container actual, restart not needs"
        else
                docker stop $container_name
                docker rm $container_name
                docker_run
        fi
fi
