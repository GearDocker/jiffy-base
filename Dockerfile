FROM python:2.7-slim-buster
MAINTAINER Gary Leong <gwleong@gmail.com>

RUN apt-get update --fix-missing && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8    

RUN apt-get update && apt-get install bash \
                                      rsync \
                                      wget \
                                      zip -y

#curl \
#vim \
#gpg \
#git -y

# Install Terraform
#RUN cd /tmp && wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip && \
#    unzip terraform_0.14.6_linux_amd64.zip && \
#    mv terraform /usr/local/bin/

RUN python -m pip install --upgrade pip

RUN pip install awscli
RUN pip install awslogs
