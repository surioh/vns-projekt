#!/bin/bash
name=tomcat
port=8080
if test "$1" != ""; then
	name="$1"
	if test "$2" != ""; then
		port="$2"
	fi
fi

docker container create \
	--name "$name" \
	--hostname "$name" \
	--volume "$PWD/www/$name:/var/www/html" \
	--net mynet \
	--publish "$port:8080" \
	image-cache
docker container cp context/myinit-tomcat.sh "$name":/usr/bin/myinit.sh
docker container start "$name"
