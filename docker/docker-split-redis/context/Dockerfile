FROM ubuntu
RUN echo moin
RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install vim tree iproute2 curl w3m ncat less procps dumb-init 
RUN apt-get -y install iproute2 net-tools iputils-ping
RUN apt-get -y install openjdk-21-jdk sudo
RUN apt-get -y install mariadb-server
RUN apt-get -y install redis redis-tools

COPY myinit.sh /usr/bin/
COPY tomcat-11.0.0.tar /opt/
RUN mkdir -p /opt/tomcat
RUN tar -xf /opt/tomcat-11.0.0.tar -C /opt/tomcat
RUN useradd tomcat
RUN chown -R tomcat:tomcat /opt/tomcat/

ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/myinit.sh"]

