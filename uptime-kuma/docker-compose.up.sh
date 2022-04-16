#!/bin/bash
BASEDIR=$(dirname "$0")
echo "$BASEDIR"
cd $BASEDIR

docker swarm init
git config --global credential.https://dev.azure.com.useHttpPath true

docker rm -f uptime-kuma-latest-1
docker-compose -f docker-compose.yml down --remove-orphans

docker network create -d overlay --attachable uptime_common_network

docker-compose -f docker-compose.yml build --progress plain --no-cache

docker-compose -f docker-compose.yml up -d --remove-orphans

# wait for a few seconds for the container to start
echo sleeping a few sec
sleep 2

echo "Opening a terminal to the Container..."
docker exec -it uptime-kuma-latest-1 /bin/bash
# ================================================= #

## ## Troubleshooting ## ##


echo "### docker logs uptime-kuma-latest-1"
docker logs uptime-kuma-latest-1
