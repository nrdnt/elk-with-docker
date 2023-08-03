# Dockerfile for 'elasticsearch'

FROM docker.elastic.co/elasticsearch/elasticsearch:7.14.1

COPY config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
