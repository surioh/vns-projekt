#!/bin/bash
log=/var/www/html/docker.log
od -vt x1 -An /dev/urandom | tr -d ' ' | head -c 4096 | ncat server 1234 && echo "$(date +%FT%T) Sent 2KB data" >> $log
for i in {0..9}; do echo $((10-i)); sleep 1; done
od -vt x1 -An /dev/urandom | tr -d ' ' | head -c1M | ncat server 1234 && echo "$(date +%FT%T) Sent 1M data" >> $log
