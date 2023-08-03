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

