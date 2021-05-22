FROM python:2.7-alpine
MAINTAINER Gary Leong <gwleong@gmail.com>

ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US
ENV LC_ALL en_US.UTF-8

RUN apk add --no-cache bash
RUN apk add --no-cache rsync

#RUN apk add --no-cache openssh-server
#RUN apk add --no-cache wget
#RUN apk add --no-cache git
#RUN apk add --no-cache curl
#RUN apk add --no-cache vim
#RUN apk add --no-cache pwgen
#RUN apk add --no-cache rng-tools
#RUN apk add --no-cache haveged
#RUN apk add --no-cache gnupg 
#RUN apk add --no-cache gcc g++ make libffi-dev openssl-dev rsync

RUN python -m pip install --upgrade pip
RUN pip install awscli
#RUN pip install awslogs
#RUN python --version
