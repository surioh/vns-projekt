#!/bin/bash

container=tomcat
[ ! -z "$1" ] && container="$1"
stats="stats/usage_log_$container.csv"
time_start=$(date +%s)

while true; do
	current=$(date +%s)
	docker stats "$container" --no-stream --format "$((current - time_start)),{{.Name}},{{.CPUPerc}},{{.MemPerc}}" >> "$stats"
	sleep 1
done
