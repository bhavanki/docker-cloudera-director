FROM openjdk:8-jre

ARG version=2.7.0

LABEL maintainer="havanki4j@gmail.com"
LABEL description="Cloudera Director Server"

RUN groupadd director && useradd -g director -m director
USER director

WORKDIR /home/director
RUN curl -O http://archive.cloudera.com/director/director/2/cloudera-director-server-${version}-director${version}.tar.gz && \
  tar xzf cloudera-director-server-${version}-director${version}.tar.gz && \
  rm cloudera-director-server-${version}-director${version}.tar.gz
EXPOSE 7189

RUN mkdir /home/director/logs
VOLUME /home/director/logs
RUN mkdir /home/director/db
VOLUME /home/director/db

ADD --chown=director:director run-director.sh /home/director
ENTRYPOINT ["/home/director/run-director.sh"]
