#!/bin/bash

export DOCKER_IMAGE=gear2000/jiffy-base:builds.ubuntu.18.04
docker build -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE 

#export DOCKER_IMAGE2=gear2000/jiffy-base:slim
#docker build -t $DOCKER_IMAGE2 . -f Dockerfile-slim
#docker push $DOCKER_IMAGE2 

export DOCKER_IMAGE3=gear2000/jiffy-base:alpine
docker build -t $DOCKER_IMAGE3 . -f Dockerfile-alpine
docker push $DOCKER_IMAGE3 
