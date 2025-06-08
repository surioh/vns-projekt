#!/bin/bash
name=mariadb
port=3306
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
	--publish "$port:3306" \
	image-cache
docker container cp context/myinit-mariadb.sh "$name":/usr/bin/myinit.sh
docker container cp context/startup "$name":/startup
docker container start "$name"
