#/bin/bash

bin/start-mariadb.sh mariadb1 3306
bin/start-mariadb.sh mariadb2 3307
bin/start-mariadb.sh mariadb3 3308
bin/start-redis.sh
bin/start-tomcat.sh tomcat1 8080
bin/start-tomcat.sh tomcat2 8081
bin/start-tomcat.sh tomcat3 8082
bin/start-tomcat.sh tomcat4 8083
bin/start-haproxy.sh haproxy 9000 8404 80
