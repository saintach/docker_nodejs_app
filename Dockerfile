# web DockerFile
FROM ubuntu:14.04

MAINTAINER Nova Saint

# Install Ubuntu essentials
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git tig htop man unzip vim wget make emacs24-nox checkinstall libssl-dev && \
  rm -rf /var/lib/apt/lists/*

# Install nodejs
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 5.1.0

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set up our PATH correctly so we don't have to long-reference npm, node
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Set up work directory
RUN mkdir -p /var/www
WORKDIR /var/www

# Install app dependencies
COPY package.json /var/www
RUN npm install

# Copy everything to app dir
COPY . /var/www

EXPOSE 8080

CMD [ "npm", "start" ]
