# Requirements

Host setup
- Docker Engine version 24.0.2 or newer
- Docker Compose version v2.18.1
- GNU Make version 4.3

By default, the exposes the following ports:

- 50000: Logstash UPD input
- 12201: Logstash UPD input
- 9200: Elasticsearch HTTP
- 9300: Elasticsearch TCP transport
- 5601: Kibana

# Usage 

Build all Dockerfiles: 
```
make build-all
```

Deploy all Docker Containers:
```
make deploy-all
```


# Default Kibana index pattern creation

When Kibana launches for the first time, it is not configured with any index pattern.

You can do this using the Kibana interface, but there is a script in this repo to automate it.

```

#!/bin/bash

username="elastic"
password="changeme"

while true; do
  response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5601/login)
  if [[ $response -eq 200 ]]; then
    curl -X POST -u "$username:$password" -H 'Content-Type: application/json' -H 'kbn-xsrf: true' -d '{
      "attributes": {
        "title": "docker-logs",
        "timeFieldName": "@timestamp"
      }
    }' http://localhost:5601/api/saved_objects/index-pattern
    break
  fi
  echo "Status.code :$response"
  sleep 10
done

```

## How to specify the amount of memory used by a service
The startup scripts for Elasticsearch and Logstash can append extra JVM options from the value of an environment variable, allowing the user to adjust the amount of memory that can be used by each component:

  Service	and Environment variable
- Elasticsearch	ES_JAVA_OPTS
- Logstash	LS_JAVA_OPTS

## How to configure Elasticsearch
The Logstash configuration is stored in elasticsearch/config/elasticsearch.yml.

## How to configure Kibana
The Kibana default configuration is stored in kibana/config/kibana.yml.

## How to configure Logstash
The Logstash configuration is stored in logstash/pipeline/logstash.conf.

## Logging driver

You can add the logging flag to the docker-compose.yml file of the containers whose logs you want to collect.

```
logging:
      driver: "gelf"
      options:
        gelf-address: "udp://<monitoring-vm-ip>:12201"

```