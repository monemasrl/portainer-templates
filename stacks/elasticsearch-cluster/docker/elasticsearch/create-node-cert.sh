#!/bin/bash

if [ -z $NODE_NAME ]; then
  echo "La variabile NODE_NAME non è definita";
  exit 1;
fi

if [ ! -f config/certs/ca.crt ]; then
  echo "Non è disponibile la CA";
  exit 1;
fi;

echo "Creating ${NODE_NAME} cert";
echo -ne \
"instances:\n" \
"  - name: ${node}\n"\
"    dns:\n"\
"      - ${node}\n"\
"      - localhost\n"\
"    ip:\n"\
"      - 127.0.0.1\n"\
> config/certs/instances.yml;
bin/elasticsearch-certutil cert --silent --pem -out config/certs/certs.zip --in config/certs/instances.yml --ca-cert config/certs/ca/ca.crt --ca-key config/certs/ca/ca.key;
unzip config/certs/certs.zip -d config/certs;
echo "Setting file permissions"
chown -R root:root config/certs;
find . -type d -exec chmod 750 \{\} \;;
find . -type f -exec chmod 640 \{\} \;;

