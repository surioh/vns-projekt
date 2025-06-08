#!/bin/bash
log="/var/www/html/docker.log"

trap onexit SIGTERM

function onexit {
	echo "Shutting down HAProxy ..." >> $log
	read pid < /var/run/haproxy.pid
        service haproxy stop
        while test "$pid" != "" ps -p $pid >/dev/null; do
                echo "wait for shutdown of pid $pid" >> $log
                sleep 0.01
        done

        exit
}

echo "Starting HAProxy ..." >> $log
service haproxy start
haproxy -f /startup-haproxy/config.cfg >> /var/www/html/haproxy.log &
echo "HAProxy Started ..." >> $log

while true; do
	echo "$(date +%FT%T)" >> $log
	read -t 1 </dev/fd/1
done

