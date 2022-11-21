docker stop $1
docker rm $1
docker run --rm -d --name $1 -p 9545:9545 --user "$(id -u):$(id -g)" -e RUST_LOG=info -e PATHFINDER_ETHEREUM_API_URL="https://eth-goerli.g.alchemy.com/v2/$2" -v $HOME/pathfinder:/usr/share/pathfinder/data $3
