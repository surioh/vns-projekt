#!/bin/bash

stats="stats/usage.csv"
time_start=$(date +%s)

while true; do
	current=$(date +%s)
	tomcat1=$(docker stats "tomcat1" --no-stream --format "$((current - time_start)),{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	tomcat2=$(docker stats "tomcat2" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	tomcat3=$(docker stats "tomcat3" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	tomcat4=$(docker stats "tomcat4" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	mariadb1=$(docker stats "mariadb1" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	mariadb2=$(docker stats "mariadb2" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	mariadb3=$(docker stats "mariadb3" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	redis=$(docker stats "redis" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	haproxy=$(docker stats "haproxy" --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}")
	echo -e "$tomcat1,$tomcat2,$tomcat3,$tomcat4,$mariadb1,$mariadb2,$mariadb3,$redis,$haproxy" >> $stats
	sleep 1
done
