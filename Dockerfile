FROM ubuntu:latest
MAINTAINER Mika Kalathil <mika@edvisor.io>

# ENV Variables
ENV NODE_VERSION 0.12.4
ENV NVM_DIR /root/.nvm

WORKDIR /root

# Update container 
RUN apt-get update -y \
    && apt-get install -yq --no-install-recommends build-essential git ca-certificates curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install NVM
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.24.2/install.sh | sh \
   && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
   && echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> .bashrc \
   && nvm install $NODE_VERSION \
   && nvm alias default $NODE_VERSION \
   && nvm use default --default \
   && ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/node /usr/bin/node \
   && ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm \
   && npm config set user 0 \
   && npm config set unsafe-perm true \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

