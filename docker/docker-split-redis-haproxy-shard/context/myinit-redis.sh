#!/bin/bash
log=/var/www/html/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  
  #shutdown ...
  echo shutting down >> $log
  read -r redispid </var/run/redis/redis-server.pid
  kill "$redispid"
  while ps -p "$redispid" >/dev/null; do
  	echo "$(date +%FT%T) waiting" >>$log
	sleep 0.1
  done
  exit
}
echo trap handler set >> $log 
# start services

# configure redis
cp /startup-redis/redis.conf /etc/redis/redis.conf
mkdir /var/run/redis
chown redis /var/run/redis

sudo -u redis redis-server /etc/redis/redis.conf

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 </dev/fd/1
done
