#!/bin/bash

stats="stats/usage.csv"
time_start=$(date +%s)

while true; do
	output=$(docker stats --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}" tomcat1 tomcat2 mariadb redis haproxy | tr '\n' ',' | sed 's/,$//')
	current=$(date +%s)
	time_elapsed=$((current - time_start))
	echo -e "$time_elapsed,$output" >> $stats
	sleep 1
done
