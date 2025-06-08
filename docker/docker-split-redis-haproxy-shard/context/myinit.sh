#!/bin/bash
log=/var/www/html/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  
  #shutdown ...
  echo shutting down >> $log
  sudo -u tomcat CATALINA_PID=/opt/tomcat/tomcat.pid /opt/tomcat/bin/shutdown.sh && echo "tomcat shutdown" >> $log
  service mariadb stop && echo "mariadb shutdown" >> $log
  exit
}
echo trap handler set >> $log 
# start services

# configure tomcat for deployment
sed -i 's:^.*allow=.*$:  allow="^.*$"/>:g' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '/^<!--therolesbegin-->/,/^<!--therolesend-->/d' /opt/tomcat/conf/tomcat-users.xml
roles='<!--therolesbegin-->\n'
roles+='  <role rolename="manager-script"/>\n'
roles+='  <role rolename="manager-gui"/>\n'
roles+='  <role rolename="manager-jmx"/>\n'
roles+='  <user username="manager" password="einfach" roles="manager-script,manager-gui,manager-jmx"/>\n'
roles+='<!--therolesend-->\n'
roles+='</tomcat-users>\n'
sed -i "s:^\s*</tomcat-users>:$roles:g" /opt/tomcat/conf/tomcat-users.xml

# configure mariadb
cp /startup/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb start && echo mariadb started >> $log
/startup/create-db.sh && echo database created >> $log
/startup/load-data.sh && echo data loaded to table products >> $log

sudo -u tomcat CATALINA_PID=/opt/tomcat/tomcat.pid /opt/tomcat/bin/startup.sh && echo tomcat started >> $log

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 </dev/fd/1
done
