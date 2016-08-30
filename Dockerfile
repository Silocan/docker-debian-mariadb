FROM debian:latest
MAINTAINER Nicolas FATREZ <docker@fatrez.com>

#RUN apt-get -y install software-properties-common
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN add-apt-repository 'deb [arch=amd64,i386] http://fr.mirror.babylon.network/mariadb/repo/10.1/debian jessie main'

RUN apt-get update;
RUN apt-get -y install mariadb-server;

EXPOSE 3306

VOLUME /backup

#ENTRYPOINT ["tail","-f","/var/log/mysql.log"]
COPY run.sh /

CMD /bin/sh /run.sh
