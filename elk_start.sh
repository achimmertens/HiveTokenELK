# !/bin/bash
# This file is to start Elasticsearch in a docker container
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -v /usr/share/elasticsearch/data:/usr/share/elasticsearch/data comworkio/elasticsearch:latest-arm
