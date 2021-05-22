FROM ubuntu:18.04
MAINTAINER Gary Leong <gwleong@gmail.com>

RUN apt-get update -y && \
    apt-get install autoconf make htop vim sysstat git zip wget python-dev \
                    rng-tools haveged python-setuptools curl python-yaml \
                    python-pip software-properties-common -y || rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && apt-get install nodejs npm -y

ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US
ENV LC_ALL en_US.UTF-8

#RUN pip install psutil 
#RUN pip install argparse==1.2.1
#RUN pip install paramiko==1.17.4
#RUN pip install pymongo==3.7.1 

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

# Install Terraform
RUN cd /tmp && wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip && \
    unzip terraform_0.14.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/

#RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
#    apt install nodejs -y

RUN mkdir -p /opt/templates/serverless /share/local
COPY package.json /opt/templates/serverless/

RUN cd /opt/templates/serverless && \
    npm i -D serverless-dotenv-plugin && \
    npm install --save-dev serverless-python-requirements && \
    npm install --save-dev serverless-wsgi && \
    sls create --template aws-nodejs --path serverless-template-project && \
    cd serverless-template-project && \
    sls plugin install -n serverless-wsgi@1.5.3 && \
    npm install serverless-domain-manager --save-dev && \

RUN npm install -g serverless@1.82.0
RUN echo "" && terraform --version
RUN echo "" && ansible --version
RUN echo "" && serverless --version

#root@serverless-deploy:/opt/dev/engine-aws-lambda# serverless --version
#Framework Core: 1.82.0 (standalone)
#Plugin: 3.8.3
#SDK: 2.3.1
#Components: 2.34.9

# Check that it's installed
