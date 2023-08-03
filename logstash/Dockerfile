# Dockerfile for 'logstash'

FROM docker.elastic.co/logstash/logstash:7.14.1

COPY config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY pipeline/logstash.conf /usr/share/logstash/pipeline/logstash.conf
COPY templates/testdata.json /usr/share/logstash/templates/testdata.json

ENV TZ="Europe/Istanbul"
