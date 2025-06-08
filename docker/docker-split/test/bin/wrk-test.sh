#!/bin/bash
url=hello
[ ! -z "$1" ] && url="$1"
wrk -c 1000 -t20 -d 10 http://localhost:8080/app/"$url"
