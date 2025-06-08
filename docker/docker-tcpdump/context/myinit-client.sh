#!/bin/bash
log=/var/www/html/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  
  #shutdown ...
  echo shutting down >> $log
  pkill -15 tcpdump
  pkill -15 ncat
  #shutdown listening server ...
  exit
}
echo "Cleanup old pcap files" >> $log
rm -f /var/www/html/*.pcap
echo "trap handler set" >> $log 
#start tcpdump ...
{
	tcpdump -l -S -tttt -nn -i eth0 port 1234 -w /var/www/html/client_segments.pcap &
} && echo "tcpdump (segments) started" >> $log

{
	tcpdump -l -S -tttt -nn -XX -i eth0 port 1234 -w /var/www/html/client_frames.pcap &
} && echo "tcpdump (frames) started" >> $log

sleep 5

od -vt x1 -An /dev/urandom | tr -d ' ' | head -c 4096 | ncat server 1234 && echo "$(date +%FT%T) Sent 2KB data" >> $log
sleep 10
od -vt x1 -An /dev/urandom | tr -d ' ' | head -c1M | ncat server 1234 && echo "$(date +%FT%T) Sent 1M data" >> $log


while true; do
	echo "$(date +%FT%T) ping" >> $log
  	read -t 20 </dev/fd/1
done
