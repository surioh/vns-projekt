#!/bin/bash
name="server"
port=1234
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
	--publish "$port:1234" \
	image-tcp
docker container cp "context/myinit-$name.sh" "$name:/usr/bin/myinit.sh"
docker container start "$name"
