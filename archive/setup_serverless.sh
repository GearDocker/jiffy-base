#!/bin/bash

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt install nodejs

npm i -D serverless-dotenv-plugin
npm install --save-dev serverless-python-requirements
npm install --save-dev serverless-wsgi
npm install serverless-domain-manager --save-dev

sls create --template aws-nodejs --path serverless-template-project
cd serverless-template-project

sls plugin install -n serverless-wsgi@1.5.3
