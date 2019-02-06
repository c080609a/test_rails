FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp

# FIX russian symbols in console
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

WORKDIR /myapp
COPY src/Gemfile /myapp/Gemfile
COPY src/Gemfile.lock /myapp/Gemfile.lock

# Bundler will store gems in /bundle
ENV BUNDLE_PATH=/gems

# RUN bundle install
COPY src/ /myapp

RUN gem install bundler
