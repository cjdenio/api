FROM ruby:2.6.6

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get -y update -qq
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get -y install nodejs postgresql-client vim poppler-utils
# install postgresql-client for easy importing of production database & vim
# for easy editing of credentials
RUN apt-get -y install build-essential libpq-dev ghostscript ledger zlib1g fontconfig libfreetype6 libx11-6 libxext6 libxrender1 --no-install-recommends
ENV EDITOR=vim

RUN npm install -g yarn

#ADD yarn.lock /usr/src/app/yarn.lock
#ADD package.json /usr/src/app/package.json
ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock

ENV BUNDLE_GEMFILE=Gemfile \
  BUNDLE_JOBS=4 \
  BUNDLE_PATH=/bundle

RUN bundle install
#RUN yarn install --check-files

ADD . /usr/src/app