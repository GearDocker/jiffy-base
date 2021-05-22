#!/bin/bash

export DOCKER_IMAGE=gear2000/jiffy-base:builds.ubuntu.18.04
docker build -t $DOCKER_IMAGE .
docker push $DOCKER_IMAGE 
