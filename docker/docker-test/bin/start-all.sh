#/bin/bash

bin/start-mariadb.sh
bin/start-redis.sh
bin/start-tomcat.sh tomcat1 8080
bin/start-tomcat.sh tomcat2 8081
bin/start-tomcat.sh tomcat3 8082
bin/start-tomcat.sh tomcat4 8083
bin/start-haproxy.sh
