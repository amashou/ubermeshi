FROM ruby:2.5.8

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       default-mysql-client \
                       --no-install-recommends \
                       && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && \
    mkdir /myapp

WORKDIR /myapp

COPY Gemfile Gemfile.lock /myapp/

ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler
RUN bundle install
COPY . /myapp
