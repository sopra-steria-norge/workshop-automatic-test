@REM This script will pull images from Azure Container Registry then build a new container image, then push the new images back to the Container registry

cd %~dp0

docker-compose -f docker-compose.yml pull --no-parallel --progress plain 

pause