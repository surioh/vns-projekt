#!/bin/bash

stats="stats/usage.csv"
time_start=$(date +%s)

while true; do
	current=$(date +%s)
	tomcat=$(docker stats "tomcat" --no-stream --format "$((current - time_start)),{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	mariadb=$(docker stats "mariadb" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	redis=$(docker stats "redis" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	echo -e "$tomcat,$mariadb,$redis" >> $stats
	sleep 1
done
