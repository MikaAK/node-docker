FROM node:latest
MAINTAINER Mika Kalathil <mika@edvisor.io>

# ENV Variables
ENV NODE_VERSION 0.12.4
WORKDIR /root

# Update docker and install npm packages
RUN apt-get update -y \
    && rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get install -yq --no-install-recommends build-essential git \
    && apt-get clean 

# Add User
RUN useradd -ms /bin/bash node \
    && mkdir /home/node/.npm \
    && chown -R node /home/node/ 

USER node
WORKDIR /home/node

# Install npm globals
RUN npm i -q --no-optional gulp bower strongloop

ADD package.json server/package.json
