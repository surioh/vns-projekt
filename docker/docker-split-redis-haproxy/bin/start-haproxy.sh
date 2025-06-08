#!/bin/bash
CONTAINERNAME="haproxy"
PORT=9000

[ "$1" != "" ] && CONTAINERNAME=$1
[ "$2" != "" ] && PORT=$2

docker container create \
        --name "$CONTAINERNAME" \
        --hostname "$CONTAINERNAME" \
        --network mynet \
	--volume "$PWD/www/$CONTAINERNAME:/var/www/html" \
        --publish "$PORT:9000" \
	--publish 8404:8404 \
	--publish 80:80 \
        image-haproxy

docker container cp context/myinit-haproxy.sh "$CONTAINERNAME:/usr/bin/myinit.sh"
docker container cp context/startup-haproxy "$CONTAINERNAME:/startup-haproxy"
docker container start "$CONTAINERNAME"
