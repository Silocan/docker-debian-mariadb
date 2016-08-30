FROM debian:latest
MAINTAINER Nicolas FATREZ <docker@fatrez.com>

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN echo "deb http://fr.mirror.babylon.network/mariadb/repo/10.1/debian jessie main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install mariadb-server;

EXPOSE 3306

VOLUME /backup

#ENTRYPOINT ["tail","-f","/var/log/mysql.log"]
COPY run.sh /

CMD /bin/sh /run.sh
