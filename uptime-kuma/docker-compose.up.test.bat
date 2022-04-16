@REM This script will pull images from Azure Container Registry rather than build image locally

cd %~dp0

set UPTIME_IMAGE_TAG=test
set UPTIME_PORT=3003

docker swarm init

docker rm -f uptime-kuma-test-1

docker tag geircode/louislam-uptime-kuma:latest geircode/louislam-uptime-kuma:test

@REM docker-compose -f docker-compose.yml down

docker network create -d overlay --attachable uptime_common_network

@REM docker-compose -f docker-compose.yml build --no-cache uptime-kuma

@REM docker-compose -f docker-compose.yml build --progress plain

@REM docker-compose -f docker-compose.yml pull --no-parallel

docker-compose -f docker-compose.yml up -d
REM wait for 1-2 seconds for the container to start
pause
docker exec -it uptime-kuma-latest-1 /bin/bash
