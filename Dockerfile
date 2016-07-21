FROM ruby:2.3.1-alpine
MAINTAINER ShopKeep Developers <developers@shopkeep.com>

RUN mkdir -p /usr/src/app

# install build/runtime dependencies inside the container
RUN apk add --no-cache make

# install language-level dependencies inside the container
ADD ./Gemfile* /tmp/
ADD ./*.gemspec /tmp/
WORKDIR /tmp
RUN bundle install --jobs 4

# copy the application source into the container
WORKDIR /usr/src/app
COPY . /usr/src/app
