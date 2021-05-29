#!/bin/bash

export DOCKER_IMAGE=gear2000/jiffy-base:builds.ubuntu.18.04
export DOCKER_IMAGE_ALPINE=gear2000/jiffy-base:alpine
#export DOCKER_IMAGE_SLIM=gear2000/jiffy-base:slim

docker build -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE 

docker build -t $DOCKER_IMAGE_ALPINE . -f Dockerfile-alpine
docker push $DOCKER_IMAGE_ALPINE 

#docker build -t $DOCKER_IMAGE_SLIM . -f Dockerfile-slim
#docker push $DOCKER_IMAGE_SLIM 
