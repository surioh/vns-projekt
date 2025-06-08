#!/bin/bash
log=/var/www/html/docker.log
echo "starte" >> $log

trap onexit SIGTERM 

function onexit {
  
  #shutdown ...
  echo "shutting down" >> $log
  pkill -15 tcpdump
  pkill -15 ncat  
  exit
}
echo "Clean old pcap files" >> $log
rm -f /var/www/html/*.pcap
echo "trap handler set" >> $log 
#start tcpdump ...

{
	tcpdump -l -S -tttt -i eth0 port 1234 -w /var/www/html/server_segments.pcap & 
} && echo "tcpdump (segments) started" >> $log

{
	tcpdump -l -S -tttt -XX -i eth0 port 1234 -w /var/www/html/server_frames.pcap &
} && echo "tcpdump (frames) started" >> $log

#start listening server ...
{
	ncat -lk 1234 >> /var/www/html/server.log 2>&1 & 
} && echo "Server ready ..." >> $log

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 </dev/fd/1
done
