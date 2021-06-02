FROM ubuntu:18.04
MAINTAINER Gary Leong <gwleong@gmail.com>

RUN apt-get update -y && \
    apt-get install autoconf make htop vim sysstat git zip wget python-dev \
                    rng-tools haveged python-setuptools curl python-yaml \
                    python-pip software-properties-common rsync zip -y || rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && apt-get install nodejs npm -y || rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US
ENV LC_ALL en_US.UTF-8

# "install docker"
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - 
RUN apt-key fingerprint 0EBFCD88 
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	                    $(lsb_release -cs) \
	                    stable"

RUN apt-get update -y && apt-get install docker-ce -y

# Install Ansible
RUN pip install ansible
RUN pip install awslogs

RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# Install Terrafor
RUN cd /tmp && wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip && \
    unzip terraform_0.14.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/

RUN mkdir -p /share/local /var/helpers /var/references /var/scripts/serverless /var/scripts/terraform
COPY create_terraform.sh /var/scripts/terraform/create.sh
COPY destroy_terraform.sh /var/scripts/terraform/destroy.sh

# Install Serverless
COPY package.json /var/templates/serverless/

RUN cd /var/templates/serverless && \
    npm install -g serverless && \
    npm install --save-dev serverless-dotenv-plugin && \
    npm install --save-dev serverless-python-requirements && \
    npm install --save-dev serverless-domain-manager && \
    npm install --save-dev serverless-wsgi 

RUN echo "" && terraform --version && \
    echo "" && ansible --version && \
    echo "" && serverless --version

#root@serverless-deploy:/var/dev/engine-aws-lambda# serverless --version
#Framework Core: 1.82.0 (standalone)
#Plugin: 3.8.3
#SDK: 2.3.1
#Components: 2.34.9

# Check that it's installed
