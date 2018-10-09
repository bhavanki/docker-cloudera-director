# Copyright 2018 William A. Havanki, Jr.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM openjdk:8-jre

ARG version=6.0.0
ARG majorVersion=6

LABEL maintainer="havanki4j@gmail.com"
LABEL description="Cloudera Director Server"

RUN groupadd director && useradd -g director -m director
USER director

WORKDIR /home/director
RUN curl -O http://archive.cloudera.com/director${majorVersion}/${version}/tars/cloudera-director-server-${version}.tar.gz && \
  tar xzf cloudera-director-server-${version}.tar.gz && \
  rm cloudera-director-server-${version}.tar.gz
EXPOSE 7189

RUN mkdir /home/director/logs
VOLUME /home/director/logs
RUN mkdir /home/director/db
VOLUME /home/director/db

ADD --chown=director:director run-director.sh /home/director
RUN sed -i s/DIRECTOR_VERSION_REPLACE_ME/DIRECTOR_VERSION=${version}/ /home/director/run-director.sh
ENTRYPOINT ["/home/director/run-director.sh"]
