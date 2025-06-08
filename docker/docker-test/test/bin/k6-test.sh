#!/bin/bash

test_script="stress.js"
[ ! -z "$1" ] && test_script="$1"

bin/clean-stats.sh
bin/docker-stats.sh tomcat1 &
monitor_tomcat1_pid=$!
bin/docker-stats.sh tomcat2 &
monitor_tomcat2_pid=$!
bin/docker-stats.sh tomcat3 &
monitor_tomcat3_pid=$!
bin/docker-stats.sh tomcat4 &
monitor_tomcat4_pid=$!
bin/docker-stats.sh redis &
monitor_redis_pid=$!
bin/docker-stats.sh mariadb &
monitor_mariadb_pid=$!
bin/docker-stats.sh haproxy &
monitor_haproxy_pid=$!

all_pids="$monitor_tomcat1_pid,$monitor_tomcat2_pid,$monitor_tomcat3_pid,$monitor_tomcat4_pid,$monitor_redis_pid,$monitor_mariadb_pid,$monitor_haproxy_pid"
echo "$all_pids"

sleep 5

k6 run "src/$test_script"

sleep 5

{
	kill "$monitor_tomcat1_pid"
	kill "$monitor_tomcat2_pid"
	kill "$monitor_tomcat3_pid"
	kill "$monitor_tomcat4_pid"
	kill "$monitor_redis_pid"
	kill "$monitor_mariadb_pid"
	kill "$monitor_haproxy_pid"
} &

while ps -p "$all_pids" >/dev/null; do
	echo "$(date +%FT%T) waiting" 
	read -r -t 1 </dev/fd/1
done

