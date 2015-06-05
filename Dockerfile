FROM ubuntu:latest
MAINTAINER Mika Kalathil <mika@edvisor.io>

# ENV Variables
ENV NODE_VERSION 0.12.4
ENV NVM_DIR /home/node/.nvm
WORKDIR /root

# Update container 
RUN apt-get update -y \
    && rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get install -yq --no-install-recommends build-essential git ca-certificates curl nodejs npm \
    && apt-get clean 

# Add User
RUN useradd -ms /bin/bash node 

ADD package.json /home/node/server/package.json
ADD client/package.json /home/node/client/package.json
ADD client/bower.json /home/node/client/bower.json

RUN chown -R node:node /home/node

USER node
WORKDIR /home/node

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.24.2/install.sh| bash \
   && source $NVM_DIR/nvm.sh \
   && nvm install $NODE_VERSION \
   && nvm alias default $NODE_VERSION \
   && nvm use default --default

RUN cd server && npm i -q
#RUN chown -R node /home/node/  \
#    && chown -R node /nodejs/ 
# #USER node #WORKDIR /home/node 
# Install npm globals
#RUN npm i -q --no-optional -g gulp bower
#RUN npm i -q --no-optional -g strongloop











