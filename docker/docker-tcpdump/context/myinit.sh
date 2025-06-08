#!/bin/bash
log=/var/www/html/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  
  #shutdown ...
  echo shutting down >> $log
  #shutdown listening server ...
  exit
}
echo trap handler set >> $log 
#start tcpdump ...
#start listening server ...

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 </dev/fd/1
done
