ARG STACK_VERSION
FROM docker.elastic.co/elasticsearch/elasticsearch:${STACK_VERSION} AS elasticsearch-dataviz
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

ARG STACK_VERSION
FROM docker.elastic.co/kibana/kibana:${STACK_VERSION} AS kibana-dataviz
USER 0
RUN apt-get update && apt-get install -y \
  iputils-ping \
  bind9-dnsutils \
  curl
USER kibana
COPY --from=elasticsearch-dataviz /usr/share/elasticsearch/config/certs /usr/share/kibana/config/certs
ADD ./docker/kibana/set_password.sh .

FROM haproxy:2.5-alpine AS haproxy
ADD ./config/haproxy /usr/local/etc/haproxy
EXPOSE 80 443 8080
