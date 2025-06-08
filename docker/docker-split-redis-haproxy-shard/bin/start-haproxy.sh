#!/bin/bash
CONTAINERNAME="haproxy"
MAIN_PORT=9000
STATS_PORT=8404
DIRECT_PORT=80

[ "$1" != "" ] && CONTAINERNAME=$1
[ "$2" != "" ] && MAIN_PORT=$2
[ "$3" != "" ] && STATS_PORT=$3
[ "$4" != "" ] && DIRECT_PORT=$4


docker container create \
        --name "$CONTAINERNAME" \
        --hostname "$CONTAINERNAME" \
        --network mynet \
	--volume "$PWD/www/$CONTAINERNAME:/var/www/html" \
        --publish "$MAIN_PORT:9000" \
	--publish "$STATS_PORT:8404" \
	--publish "$DIRECT_PORT:80" \
        image-haproxy

docker container cp context/myinit-haproxy.sh "$CONTAINERNAME:/usr/bin/myinit.sh"
docker container cp context/startup-"$CONTAINERNAME" "$CONTAINERNAME:/startup-haproxy"
docker container start "$CONTAINERNAME"
