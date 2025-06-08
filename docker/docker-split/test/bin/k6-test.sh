#!/bin/bash

test_script="stress.js"
[ ! -z "$1" ] && test_script="$1"

bin/clean-stats.sh
bin/docker-stats.sh &
monitor_pid=$!
echo "$monitor_pid"

sleep 5

k6 run "src/$test_script"

sleep 5

kill "$monitor_pid"
while ps -p "$monitor_pid" >/dev/null; do
	echo "$(date +%FT%T) waiting" 
	read -r -t 1 </dev/fd/1
done

