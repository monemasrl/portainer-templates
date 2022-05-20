#!/bin/bash

if [ -z "$ELASTIC_PASSWORD" ]; then
	echo "Devi impostare la variabile ELASTIC_PASSWORD"
	exit 1;
fi

if [ -z "$KIBANA_PASSWORD" ]; then
	echo "Devi impostare la variabile KIBANA_PASSWORD"
	exit 1;
fi

 /usr/bin/curl -X POST \
	  --cacert config/certs/ca/ca.crt \
	  -u elastic:${ELASTIC_PASSWORD} \
	  -H 'Content-Type: application/json' \
	  https://localhost:9200/_security/user/kibana_system/_password \
	  -d "{\"password\":\"$KIBANA_PASSWORD\"}";
