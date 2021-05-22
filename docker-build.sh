#!/bin/bash

export DOCKER_IMAGE=gear2000/jiffy-base:slim
docker build -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE 
