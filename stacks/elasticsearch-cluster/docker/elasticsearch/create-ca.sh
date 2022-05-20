#!/bin/bash

if [ ! -f config/certs/ca.zip ]; then
  mkdir -p config/certs;
  echo "Creating CA";
  echo $PWD;
  bin/elasticsearch-certutil ca --silent --pem -out config/certs/ca.zip;
  ls -la config;
  unzip /usr/share/elasticsearch/config/certs/ca.zip -d /usr/share/elasticsearch/config/certs;
fi;

echo "Setting file permissions"
chown -R elasticsearch:elasticsearch config/certs;
find config/certs -type d -exec chmod 750 \{\} \;;
find config/certs -type f -exec chmod 640 \{\} \;;

