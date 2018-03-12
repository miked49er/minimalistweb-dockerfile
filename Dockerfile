# Minimalist Web Development Environment
#
# VERSION 0.0.0

FROM debian:jessie

# Environment Variables
ENV dev /mnt/dev
ENV project /mnt/dev/project
WORKDIR $project

# Update the system and install npm, ruby, and curl
RUN apt-get -y update \
  && apt-get -y install npm ruby-full curl

# Setup node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs

# Install sass and compass
RUN gem install sass --no-user-install \
  && gem install compass

# Install required node modules
RUN npm install -g grunt-cli \
  && cd $dev \
  && npm install grunt \
    grunt-contrib-compass \
    grunt-contrib-jshint \
    grunt-contrib-uglify \
    grunt-contrib-watch \
    grunt-http-server

CMD /bin/ln -s $dev/node_modules $project/node_modules
CMD /bin/sh -c cd $project/ && npm run dev
