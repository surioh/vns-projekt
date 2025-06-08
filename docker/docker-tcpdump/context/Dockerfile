FROM ubuntu
RUN echo moin
RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install vim tree iproute2 ncat procps dumb-init
RUN apt-get -y install tcpdump

ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/myinit.sh"]

