#/bin/bash

bin/start-mariadb.sh
bin/start-redis.sh
bin/start-tomcat.sh tomcat1 8080
bin/start-tomcat.sh tomcat2 8081
bin/start-haproxy.sh
