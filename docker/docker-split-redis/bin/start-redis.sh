#!/bin/bash
name=redis
port=6300

docker container create \
	--name "$name" \
	--hostname "$name" \
	--volume "$PWD/www/$name:/var/www/html" \
	--net mynet \
	--publish "$port:6379" \
	image-cache
docker container cp context/myinit-redis.sh "$name":/usr/bin/myinit.sh
docker container cp context/startup-redis "$name":/startup-redis
docker container start "$name"
