FROM docker.elastic.co/kibana/kibana:8.1.3 AS kibana
ADD ./data/certs /usr/share/kibana/config/certs
ADD ./docker/kibana/set_password.sh .
USER 0
RUN apt-get update && apt-get install -y \
  iputils-ping \
  bind9-dnsutils \
  curl
USER kibana

#FROM docker.elastic.co/elasticsearch/elasticsearch:8.1.3 AS elasticsearch
#ADD ./data/certs /usr/share/elasticsearch/config/certs
#ADD ./docker/elasticsearch/set_password.sh .
#USER 0
#RUN apt-get update && apt-get install -y \
#  iputils-ping \
#  bind9-dnsutils \
#  curl
#USER elasticsearch

FROM docker.elastic.co/elasticsearch/elasticsearch:8.1.3 AS elasticsearch
USER 0
RUN apt-get update && apt-get install -y \
  iputils-ping \
  bind9-dnsutils \
  curl
ADD ./docker/elasticsearch/create-ca.sh /usr/local/bin/
ADD ./docker/elasticsearch/create-node-cert.sh /usr/local/bin/
ADD ./docker/elasticsearch/set_password.sh /usr/local/bin/
ADD ./docker/elasticsearch/docker-entrypoint.sh /usr/local/bin/
RUN /usr/local/bin/create-ca.sh
USER elasticsearch

FROM haproxy:2.5-alpine AS haproxy
ADD ./config/haproxy /usr/local/etc/haproxy
EXPOSE 80 443 8080
