#!/bin/bash

#source /tmp/.credentials/docker/gear2000-token.txt 
source ./build_params.txt

docker build -t $DOCKER_IMAGE . || exit 9

echo "logging into docker"
echo $DOCKER_TOKEN | docker login --username gear2000 --password-stdin || exit 9

docker push $DOCKER_IMAGE 
