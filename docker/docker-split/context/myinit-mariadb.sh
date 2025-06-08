#!/bin/bash
log=/var/www/html/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  
  #shutdown ...
  echo shutting down >> $log
  service mariadb stop
  exit
}
echo trap handler set >> $log 
# start services

# configure mariadb
cp /startup/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb start && echo mariadb started >> $log
/startup/create-db.sh && echo database created >> $log
/startup/load-data.sh && echo data loaded to table products >> $log

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 </dev/fd/1
done
