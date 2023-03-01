# !/bin/bash

# ------------------- Steart ELK ------------------
# This file is to start Elasticsearch in a docker container
# docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -v /usr/share/elasticsearch/data:/usr/share/elasticsearch/data comworkio/elasticsearch:latest-arm
docker start elasti
docker start hammurabi
sudo service kibana start




# -------------------- Stop ELK -------------------
#
# sudo service klibana stop
#
# docker ps
# docker stop 2b5 (Container ID)
# sudo reboot
