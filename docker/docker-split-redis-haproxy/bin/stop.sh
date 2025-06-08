#!/bin/bash
name="tomcat"
if test "$1" != ""; then
	name="$1"
fi
docker container stop "$name"
docker container rm "$name"
